//! Port of `packages/quicktype-core/src/language/Scala3/UpickleRenderer.ts`.
//!
//! Scala 3 types with upickle `ReadWriter`s: a custom `OptionPickler`,
//! derived picklers for case classes, string picklers for enums and strict
//! readers for untagged unions.

use crate::convenience_renderer::ConvenienceRendererCore;
use crate::convenience_renderer::prelude::*;
use crate::support::strings::{string_escape, utf16_string_escape};
use crate::target_language::TargetLanguage;
use crate::ty::type_utils::{NullRemovalSort, remove_null_from_union};

use super::scala3_renderer::{
    Scala3Options, Scala3RendererFamily, Scala3State, scala3_hooks, scala3_methods,
};
use super::utils::{property_name_needs_mapping, union_member_sort_order, wrap_option};

/// The support code after the package line: the `OptionPickler`, the
/// `NullValue`, date-time and UUID picklers and the strict readers.
const HEADER: &str = r#"// Custom pickler so that missing keys and JSON nulls both read as None,
// and None is left out when writing (upickle's default for Option is a
// JSON array).
object OptionPickler extends upickle.AttributeTagged:
    import upickle.default.Writer
    import upickle.default.Reader
    override implicit def OptionWriter[T: Writer]: Writer[Option[T]] =
        implicitly[Writer[T]].comap[Option[T]] {
            case None => null.asInstanceOf[T]
            case Some(x) => x
        }

    override implicit def OptionReader[T: Reader]: Reader[Option[T]] = {
        new Reader.Delegate[Any, Option[T]](implicitly[Reader[T]].map(Some(_))){
        override def visitNull(index: Int) = None
        }
    }
end OptionPickler

// If a union has a null in, then we'll need this too...
type NullValue = None.type
given OptionPickler.ReadWriter[NullValue] = OptionPickler.readwriter[ujson.Value].bimap[NullValue](
    _ => ujson.Null,
    json => if json.isNull then None else throw new upickle.core.Abort("not null")
)
given OptionPickler.ReadWriter[java.time.Instant] = OptionPickler.readwriter[ujson.Value].bimap(
    value => ujson.Str(value.toString),
    json => json match
        case ujson.Str(value) => java.time.Instant.parse(value)
        case other => throw new upickle.core.Abort("expected date-time, got " + other)
)
given OptionPickler.ReadWriter[java.util.UUID] = OptionPickler.readwriter[String].bimap(
    _.toString,
    value =>
        val uuid = java.util.UUID.fromString(value)
        if uuid.toString.equalsIgnoreCase(value) then uuid else throw new upickle.core.Abort("invalid UUID")
)

object JsonExt:
    val valueReader = OptionPickler.readwriter[ujson.Value]

    // upickle's built-in primitive readers are lenient -- the numeric and
    // boolean readers accept strings, and the string reader accepts
    // numbers and booleans -- so untagged unions need strict readers to
    // pick the right member.
    val strictString: OptionPickler.Reader[String] = valueReader.map {
        case ujson.Str(s) => s
        case json => throw new upickle.core.Abort("expected string, got " + json)
    }
    val strictLong: OptionPickler.Reader[Long] = valueReader.map {
        case ujson.Num(n) if n.isWhole => n.toLong
        case json => throw new upickle.core.Abort("expected integer, got " + json)
    }
    val strictDouble: OptionPickler.Reader[Double] = valueReader.map {
        case ujson.Num(n) => n
        case json => throw new upickle.core.Abort("expected number, got " + json)
    }
    val strictBoolean: OptionPickler.Reader[Boolean] = valueReader.map {
        case ujson.Bool(b) => b
        case json => throw new upickle.core.Abort("expected boolean, got " + json)
    }

    def badMerge[T](r1: => OptionPickler.Reader[?], rest: OptionPickler.Reader[?]*): OptionPickler.Reader[T] = valueReader.map { json =>
        var t: T | Null = null
        val stack       = Vector.newBuilder[Throwable]
        (r1 +: rest).foreach { reader =>
            if t == null then
            try
                t = OptionPickler.read[T](json, trace = true)(using reader.asInstanceOf[OptionPickler.Reader[T]])
            catch
                case exc => stack += exc
        }
        if t != null then t.nn else throw new Exception(json.toString(), stack.result().headOption.getOrElse(null))
    }
end JsonExt
given OptionPickler.Reader[Long] = JsonExt.strictLong
"#;

/// `UpickleRenderer`.
pub struct UpickleRenderer<'a> {
    core: ConvenienceRendererCore<'a>,
    scala3: Scala3State,
    /// `seenUnionTypes`: the unions whose picklers were already emitted, as
    /// their `A | B` strings.
    seen_union_types: Vec<String>,
}

impl std::fmt::Debug for UpickleRenderer<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("UpickleRenderer")
            .field("scala3", &self.scala3)
            .finish_non_exhaustive()
    }
}

impl<'a> UpickleRenderer<'a> {
    /// `new UpickleRenderer(targetLanguage, renderContext, options)`.
    pub fn new(
        target_language: &'a dyn TargetLanguage,
        render_context: RenderContext<'a>,
        options: Scala3Options,
    ) -> Self {
        UpickleRenderer {
            core: ConvenienceRendererCore::new(target_language, render_context),
            scala3: Scala3State::new(options),
            seen_union_types: Vec::new(),
        }
    }
}

/// The strict reader for a primitive union member rendered as `scala_type`
/// (upickle's own readers accept too much; see `JsonExt`).
fn strict_reader(scala_type: &str) -> Option<&'static str> {
    match scala_type {
        "Boolean" => Some("JsonExt.strictBoolean"),
        "Double" => Some("JsonExt.strictDouble"),
        "Long" => Some("JsonExt.strictLong"),
        "String" => Some("JsonExt.strictString"),
        _ => None,
    }
}

impl<'a> ConvenienceRenderer<'a> for UpickleRenderer<'a> {
    fn core(&self) -> &ConvenienceRendererCore<'a> {
        &self.core
    }

    fn core_mut(&mut self) -> &mut ConvenienceRendererCore<'a> {
        &mut self.core
    }

    forward_convenience_renderer_hooks!(scala3_hooks);
}

impl<'a> Scala3RendererFamily<'a> for UpickleRenderer<'a> {
    fn scala3(&self) -> &Scala3State {
        &self.scala3
    }

    fn emit_class_definition_methods(&mut self, _c: TypeRef, _class_name: Name) -> Result<()> {
        self.emit_line(") derives OptionPickler.ReadWriter");
        Ok(())
    }

    /// `@upickle.implicits.key(...)` for a JSON name the field can't have.
    fn emit_property_annotation(&mut self, _name: Name, json_name: &str) -> Result<()> {
        if property_name_needs_mapping(json_name)? {
            self.emit_line(format!(
                "@upickle.implicits.key(\"{}\")",
                utf16_string_escape(json_name)
            ));
        }
        Ok(())
    }

    fn any_source_type(&self, optional: bool) -> Source {
        sl![wrap_option("ujson.Value", optional)]
    }

    fn emit_header(&mut self) -> Result<()> {
        scala3_methods::emit_header(self)?;
        self.emit_multiline(HEADER)?;
        self.ensure_blank_line();
        Ok(())
    }

    fn emit_empty_class_definition(&mut self, c: TypeRef, class_name: Name) -> Result<()> {
        scala3_methods::emit_empty_class_definition(self, c, class_name)?;
        self.emit_item(" derives OptionPickler.ReadWriter");
        self.ensure_blank_line();
        Ok(())
    }

    /// The type alias, and, for the first union with these members, a
    /// reader trying each member and a writer matching on them.
    ///
    /// Like the TypeScript, this repeats the base class's alias code and
    /// the other framework's member ordering rather than sharing them.
    fn emit_union_definition(&mut self, u: TypeRef, union_name: Name) -> Result<()> {
        let description = self.description_for_type(u)?;
        self.emit_description(description)?;

        let (maybe_null, non_nulls) =
            remove_null_from_union(self.type_graph(), u, NullRemovalSort::None)?;
        let mut the_types: Vec<Source> = Vec::new();
        self.for_each_union_member(
            u,
            Some(&non_nulls),
            BlankLinePosition::None,
            None,
            |r, _, t, _| {
                the_types.push(r.scala_type(t, false, false)?);
                Ok(())
            },
        )?;
        if let Some(null_type) = maybe_null {
            the_types.push(self.name_for_union_member(u, null_type)?.into());
        }

        self.emit_item(sl!["type ", union_name, " = "]);
        for (i, t) in the_types.iter().enumerate() {
            if i == 0 {
                self.emit_item(t.clone());
            } else {
                self.emit_item(sl![" | ", t.clone()]);
            }
        }
        let this_union_type = the_types
            .iter()
            .map(|x| self.sourcelike_to_string(x))
            .collect::<Result<Vec<_>>>()?
            .join(" | ");

        self.ensure_blank_line();
        if self.seen_union_types.contains(&this_union_type) {
            return Ok(());
        }
        self.seen_union_types.push(this_union_type);

        let mut source_like_types: Vec<(Source, TypeRef)> = Vec::new();
        let sort_order = |r: &Self, _: Name, t: TypeRef| -> Result<String> {
            Ok(union_member_sort_order(r.type_graph().kind(t)?))
        };
        self.for_each_union_member(
            u,
            Some(&non_nulls),
            BlankLinePosition::None,
            Some(&sort_order),
            |r, _, t, _| {
                source_like_types.push((r.scala_type(t, false, false)?, t));
                Ok(())
            },
        )?;
        if let Some(null_type) = maybe_null {
            source_like_types.push((self.name_for_union_member(u, null_type)?.into(), null_type));
        }

        self.ensure_blank_line();
        self.emit_line(sl![
            "given unionReader",
            union_name,
            ": OptionPickler.Reader[",
            union_name,
            "] = JsonExt.badMerge[",
            union_name,
            "]("
        ]);
        self.indent(|r| {
            for (src_type, t) in &source_like_types {
                // Use the strict readers for primitive members -- upickle's
                // built-in ones accept too much (see the comment in the
                // emitted JsonExt).
                let strict = if r.type_graph().type_at(*t)?.is_primitive() {
                    strict_reader(&r.sourcelike_to_string(src_type)?)
                } else {
                    None
                };
                match strict {
                    None => {
                        r.emit_line(sl!["summon[OptionPickler.Reader[", src_type.clone(), "]],"])
                    }
                    Some(strict) => r.emit_line(sl![strict, ","]),
                }
            }
            r.emit_line(")");
            Ok(())
        })?;
        self.ensure_blank_line();
        self.emit_line(sl![
            "given unionWriter",
            union_name,
            ": OptionPickler.Writer[",
            union_name,
            "] = OptionPickler.writer[ujson.Value].comap[",
            union_name,
            "]{ _v =>"
        ]);
        self.indent(|r| {
            r.emit_line("(_v: @unchecked) match ");
            r.indent(|r| {
                for (src_type, _) in &source_like_types {
                    r.emit_line(sl![
                        "case v: ",
                        src_type.clone(),
                        " => OptionPickler.writeJs[",
                        src_type.clone(),
                        "](v)"
                    ]);
                }
                Ok(())
            })
        })?;
        self.emit_line("}");
        Ok(())
    }

    /// An `enum` of styled cases with a string `ReadWriter` mapping them to
    /// the JSON strings.
    fn emit_enum_definition(&mut self, e: TypeRef, enum_name: Name) -> Result<()> {
        let description = self.description_for_type(e)?;
        self.emit_description(description)?;
        self.ensure_blank_line();

        self.emit_line(sl!["enum ", enum_name, " : "]);
        self.indent(|r| {
            r.for_each_enum_case(e, BlankLinePosition::None, |r, name, _, _| {
                r.emit_line(sl!["case ", name]);
                Ok(())
            })
        })?;
        self.ensure_blank_line();

        self.emit_line(sl![
            "given OptionPickler.ReadWriter[",
            enum_name,
            "] = OptionPickler.readwriter[String].bimap[",
            enum_name,
            "]("
        ]);
        self.indent(|r| {
            r.emit_line("{");
            r.indent(|r| {
                r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                    r.emit_line(sl![
                        "case ",
                        enum_name,
                        ".",
                        name,
                        format!(" => \"{}\"", string_escape(json_name))
                    ]);
                    Ok(())
                })
            })?;
            r.emit_line("},");
            r.emit_line("{");
            r.indent(|r| {
                r.for_each_enum_case(e, BlankLinePosition::None, |r, name, json_name, _| {
                    r.emit_line(sl![
                        format!("case \"{}\" => ", string_escape(json_name)),
                        enum_name,
                        ".",
                        name
                    ]);
                    Ok(())
                })?;
                r.emit_line(sl![
                    "case other => throw new upickle.core.Abort(\"invalid ",
                    enum_name,
                    ": \" + other)"
                ]);
                Ok(())
            })?;
            r.emit_line("}");
            Ok(())
        })?;
        self.emit_line(")");
        self.ensure_blank_line();
        Ok(())
    }
}

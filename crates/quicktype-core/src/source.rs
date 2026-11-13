//! Port of `packages/quicktype-core/src/Source.ts`.
//!
//! The tree of generated code ([`Source`]) and its serialization into lines
//! ([`serialize_render_result`]).
//!
//! The TypeScript `Sourcelike` (a string, a `Name`, an array of
//! sourcelikes or a `Source`) is [`Source`] itself here: anything that
//! converts `Into<Source>` can be emitted, and the [`sl!`](crate::sl) macro
//! builds a sequence the way a TS array literal does:
//!
//! ```
//! use quicktype_core::sl;
//! use quicktype_core::source::Source;
//! let line: Source = sl!["pub struct ", "Foo", " {"];
//! ```
//!
//! Strings are kept as one [`Source::Text`] even if they contain `"\n"`;
//! serialization splits them exactly where `sourcelikeToSource` would have
//! (on `"\n"` only, so `"\r"` survives), with the same effect on
//! indentation, columns and table widths.
//!
//! All widths and columns count UTF-16 code units, as JavaScript's
//! `.length` does.

use std::fmt;
use std::rc::Rc;

use quicktype_js_compat::utf16;

use crate::annotation::AnnotationData;
use crate::messages::Result;
use crate::naming::{Name, Names};
use crate::support::support::{assert, defined, panic};

/// A function applied to the serialized text of a [`Source::Modified`].
pub type Modifier = Rc<dyn Fn(&str) -> String>;

/// `Source`: a tree of generated code.
#[derive(Clone)]
pub enum Source {
    /// `text`: literal text. A `"\n"` inside starts a new line, like the
    /// newlines `sourcelikeToSource` inserts. As an emitted item it stands
    /// for a TS *string* (compared by value in `emitLineOnce`); TS renderers
    /// never build `{ kind: "text" }` objects themselves.
    Text(String),
    /// `newline`: ends the line and changes the indentation of the following
    /// lines by this many levels.
    Newline(i32),
    /// `sequence`: the parts, one after another.
    Sequence(Vec<Source>),
    /// `table`: rows of cells, padded with spaces into aligned columns.
    Table(Vec<Vec<Source>>),
    /// `annotated`: a source with an annotation spanning it.
    Annotated(AnnotationData, Box<Source>),
    /// `name`: the string assigned to a [`Name`].
    Name(Name),
    /// `modified`: the serialized single line of the source, passed through
    /// the modifier.
    Modified(Modifier, Box<Source>),
}

impl fmt::Debug for Source {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Source::Text(t) => f.debug_tuple("Text").field(t).finish(),
            Source::Newline(n) => f.debug_tuple("Newline").field(n).finish(),
            Source::Sequence(s) => f.debug_tuple("Sequence").field(s).finish(),
            Source::Table(t) => f.debug_tuple("Table").field(t).finish(),
            Source::Annotated(a, s) => f.debug_tuple("Annotated").field(a).field(s).finish(),
            Source::Name(n) => f.debug_tuple("Name").field(n).finish(),
            Source::Modified(_, s) => f.debug_tuple("Modified").field(s).finish(),
        }
    }
}

impl From<&str> for Source {
    fn from(s: &str) -> Self {
        Source::Text(s.to_owned())
    }
}

impl From<String> for Source {
    fn from(s: String) -> Self {
        Source::Text(s)
    }
}

impl From<&String> for Source {
    fn from(s: &String) -> Self {
        Source::Text(s.clone())
    }
}

impl From<std::borrow::Cow<'_, str>> for Source {
    fn from(s: std::borrow::Cow<'_, str>) -> Self {
        Source::Text(s.into_owned())
    }
}

impl From<Name> for Source {
    fn from(n: Name) -> Self {
        Source::Name(n)
    }
}

impl From<&Name> for Source {
    fn from(n: &Name) -> Self {
        Source::Name(*n)
    }
}

impl From<Vec<Source>> for Source {
    fn from(v: Vec<Source>) -> Self {
        Source::Sequence(v)
    }
}

impl From<&Source> for Source {
    fn from(s: &Source) -> Self {
        s.clone()
    }
}

impl From<&[Source]> for Source {
    fn from(v: &[Source]) -> Self {
        Source::Sequence(v.to_vec())
    }
}

impl Source {
    /// Whether this is the empty sequence (TS `[]`).
    pub fn is_empty_sequence(&self) -> bool {
        matches!(self, Source::Sequence(v) if v.is_empty())
    }

    /// Calls `f` on every [`Name`] in the tree, in order (what JavaScript
    /// renderers find by walking a gathered `Sourcelike` tree).
    pub fn for_each_name(&self, f: &mut dyn FnMut(Name)) {
        match self {
            Source::Text(_) | Source::Newline(_) => {}
            Source::Sequence(s) => s.iter().for_each(|x| x.for_each_name(f)),
            Source::Table(t) => t.iter().flatten().for_each(|x| x.for_each_name(f)),
            Source::Annotated(_, s) | Source::Modified(_, s) => s.for_each_name(f),
            Source::Name(n) => f(*n),
        }
    }
}

/// Builds a [`Source`] from sourcelikes like a TS array literal: always a
/// [`Source::Sequence`], also for zero or one part. Every part goes through
/// `Source::from`.
///
/// The distinction from the part itself matters for `emitLineOnce` and
/// `emitItemOnce`, which compare items with JavaScript `===`: a string item
/// (`emit_line("x")`) equals an earlier string item with the same text, an
/// array item (`emit_line(sl!["x"])`, TS `emitLine(["x"])`) equals nothing.
#[macro_export]
macro_rules! sl {
    ($($x:expr),* $(,)?) => {
        $crate::source::Source::Sequence(::std::vec![$($crate::source::Source::from($x)),*])
    };
}

/// `newline()`: a line break without an indentation change.
pub fn newline() -> Source {
    Source::Newline(0)
}

/// `annotated(annotation, sl)`.
pub fn annotated(annotation: AnnotationData, sl: impl Into<Source>) -> Source {
    Source::Annotated(annotation, Box::new(sl.into()))
}

/// `maybeAnnotated(doAnnotate, annotation, sl)`: `sl` itself unless
/// `do_annotate`.
pub fn maybe_annotated(
    do_annotate: bool,
    annotation: AnnotationData,
    sl: impl Into<Source>,
) -> Source {
    if !do_annotate {
        return sl.into();
    }
    annotated(annotation, sl)
}

/// `modifySource(modifier, sl)`: `modifier` is applied to the serialized
/// text of `sl`, which must be a single line.
pub fn modify_source(modifier: impl Fn(&str) -> String + 'static, sl: impl Into<Source>) -> Source {
    Source::Modified(Rc::new(modifier), Box::new(sl.into()))
}

/// `Location`: zero-based line and UTF-16 column.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Location {
    /// Zero-based line.
    pub line: usize,
    /// Zero-based column in UTF-16 code units.
    pub column: usize,
}

/// `Span`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Span {
    /// Where the annotated source starts.
    pub start: Location,
    /// Where it ends.
    pub end: Location,
}

/// `Annotation`: an annotation and the span it covers.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Annotation {
    /// The annotation.
    pub annotation: AnnotationData,
    /// The annotated span.
    pub span: Span,
}

/// `SerializedRenderResult`: the lines of a file (joined with `"\n"` they
/// are the file's contents) and its annotations.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct SerializedRenderResult {
    /// The lines; the last one is empty if the file ends with a newline.
    pub lines: Vec<String>,
    /// The annotations, in order of their ends.
    pub annotations: Vec<Annotation>,
}

fn name_string(names: &Names, name: Name) -> Result<&str> {
    defined(names.get(name))
}

/// `sourceLineLength(source, names)`: the UTF-16 length of a single-line
/// source.
fn source_line_length(source: &Source, names: &Names) -> Result<usize> {
    match source {
        Source::Text(t) => {
            if t.contains('\n') {
                return panic("Newline must not occur within a line.");
            }
            Ok(utf16::len(t))
        }
        Source::Newline(_) => panic("Newline must not occur within a line."),
        Source::Sequence(s) => {
            let mut total = 0;
            for x in s {
                total += source_line_length(x, names)?;
            }
            Ok(total)
        }
        Source::Table(_) => panic("Table must not occur within a  line."),
        Source::Annotated(_, s) => source_line_length(s, names),
        Source::Name(n) => Ok(utf16::len(name_string(names, *n)?)),
        Source::Modified(..) => {
            let lines = serialize_render_result(source, names, "")?.lines;
            Ok(utf16::len(&lines.join("\n")))
        }
    }
}

struct Serializer<'n> {
    names: &'n Names,
    indentation: &'n str,
    indent: i64,
    indent_needed: i64,
    lines: Vec<String>,
    current_line: String,
    annotations: Vec<Annotation>,
}

impl Serializer<'_> {
    fn indent_if_needed(&mut self) -> Result<()> {
        if self.indent_needed == 0 {
            return Ok(());
        }
        assert(
            self.indent_needed >= 0,
            "Cannot repeat a string a negative number of times",
        )?;
        for _ in 0..self.indent_needed {
            self.current_line.push_str(self.indentation);
        }
        self.indent_needed = 0;
        Ok(())
    }

    fn current_location(&self) -> Location {
        Location {
            line: self.lines.len(),
            column: utf16::len(&self.current_line),
        }
    }

    fn finish_line(&mut self) {
        self.lines.push(std::mem::take(&mut self.current_line));
    }

    fn newline(&mut self, indentation_change: i32) {
        self.finish_line();
        self.indent += i64::from(indentation_change);
        self.indent_needed = self.indent;
    }

    fn serialize(&mut self, source: &Source) -> Result<()> {
        match source {
            Source::Text(text) => {
                for (i, piece) in text.split('\n').enumerate() {
                    if i > 0 {
                        self.newline(0);
                    }
                    self.indent_if_needed()?;
                    self.current_line.push_str(piece);
                }
            }
            Source::Newline(change) => self.newline(*change),
            Source::Sequence(s) => {
                for x in s {
                    self.serialize(x)?;
                }
            }
            Source::Table(table) => self.serialize_table(table)?,
            Source::Annotated(annotation, s) => {
                let start = self.current_location();
                self.serialize(s)?;
                let end = self.current_location();
                self.annotations.push(Annotation {
                    annotation: annotation.clone(),
                    span: Span { start, end },
                });
            }
            Source::Name(n) => {
                let s = match self.names.get(*n) {
                    Some(s) => s,
                    None => return panic("No name for Named"),
                };
                self.indent_if_needed()?;
                self.current_line.push_str(s);
            }
            Source::Modified(modifier, s) => {
                self.indent_if_needed()?;
                let serialized = serialize_render_result(s, self.names, self.indentation)?.lines;
                assert(serialized.len() == 1, "Cannot modify more than one line.")?;
                self.current_line.push_str(&modifier(&serialized[0]));
            }
        }
        Ok(())
    }

    fn serialize_table(&mut self, table: &[Vec<Source>]) -> Result<()> {
        let num_rows = table.len();
        if num_rows == 0 {
            return Ok(());
        }
        let widths: Vec<Vec<usize>> = table
            .iter()
            .map(|row| {
                row.iter()
                    .map(|cell| source_line_length(cell, self.names))
                    .collect::<Result<_>>()
            })
            .collect::<Result<_>>()?;
        let num_columns = table.iter().map(Vec::len).max().unwrap_or(0);
        if num_columns == 0 {
            return Ok(());
        }
        let column_widths: Vec<usize> = (0..num_columns)
            .map(|i| {
                widths
                    .iter()
                    .map(|row| row.get(i).copied().unwrap_or(0))
                    .max()
                    .unwrap_or(0)
            })
            .collect();

        let empty = Source::Text(String::new());
        for (y, row) in table.iter().enumerate() {
            self.indent_if_needed()?;
            for (x, &column_width) in column_widths.iter().enumerate() {
                let src = row.get(x).unwrap_or(&empty);
                let src_width = widths[y].get(x).copied().unwrap_or(0);
                self.serialize(src)?;
                if x < num_columns - 1 && src_width < column_width {
                    self.current_line
                        .push_str(&" ".repeat(column_width - src_width));
                }
            }
            if y < num_rows - 1 {
                self.finish_line();
                self.indent_needed = self.indent;
            }
        }
        Ok(())
    }
}

/// `serializeRenderResult(rootSource, names, indentation)`: the lines of
/// the source, with `indentation` repeated once per indentation level, and
/// the spans of its annotations.
pub fn serialize_render_result(
    root_source: &Source,
    names: &Names,
    indentation: &str,
) -> Result<SerializedRenderResult> {
    let mut serializer = Serializer {
        names,
        indentation,
        indent: 0,
        indent_needed: 0,
        lines: Vec::new(),
        current_line: String::new(),
        annotations: Vec::new(),
    };
    serializer.serialize(root_source)?;
    serializer.finish_line();
    Ok(SerializedRenderResult {
        lines: serializer.lines,
        annotations: serializer.annotations,
    })
}

/// `MultiWord`: a type expression that may need parentheses when nested.
#[derive(Clone, Debug)]
pub struct MultiWord {
    /// Whether the source consists of several words.
    pub needs_parens: bool,
    /// The words.
    pub source: Source,
}

/// `singleWord(...source)`.
pub fn single_word(source: Vec<Source>) -> MultiWord {
    MultiWord {
        source: Source::Sequence(source),
        needs_parens: false,
    }
}

/// `multiWord(separator, ...words)`: the words separated by `separator`;
/// errors for zero words.
pub fn multi_word(separator: impl Into<Source>, words: Vec<Source>) -> Result<MultiWord> {
    assert(!words.is_empty(), "Zero words is not multiple")?;
    if words.len() == 1 {
        let mut words = words;
        return Ok(single_word(vec![words.remove(0)]));
    }
    let separator = separator.into();
    let mut items = Vec::with_capacity(words.len() * 2 - 1);
    for (i, w) in words.into_iter().enumerate() {
        if i > 0 {
            items.push(separator.clone());
        }
        items.push(w);
    }
    Ok(MultiWord {
        source: Source::Sequence(items),
        needs_parens: true,
    })
}

/// `parenIfNeeded(multiWord)`.
pub fn paren_if_needed(mw: MultiWord) -> Source {
    if mw.needs_parens {
        return sl!["(", mw.source, ")"];
    }
    mw.source
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::naming::{Namer, Naming, assign_names};

    fn lines(source: &Source) -> Vec<String> {
        serialize_render_result(source, &Names::new(), "  ")
            .unwrap()
            .lines
    }

    #[test]
    fn splits_text_on_newlines_only() {
        let s = sl![
            "a\nb\r",
            Source::Newline(1),
            "c\nd",
            Source::Newline(-1),
            "e"
        ];
        assert_eq!(lines(&s), ["a", "b\r", "  c", "  d", "e"]);
    }

    #[test]
    fn indentation_only_appears_before_content() {
        let s = sl![
            "x",
            Source::Newline(1),
            Source::Newline(0),
            "",
            Source::Newline(-1)
        ];
        assert_eq!(lines(&s), ["x", "", "  ", ""]);
    }

    #[test]
    fn tables_pad_every_column_but_the_last() {
        let table = Source::Table(vec![
            vec!["a".into(), "bbb".into(), "c".into()],
            vec!["dddd".into()],
            vec!["😀".into(), "e".into()],
        ]);
        let s = sl![Source::Newline(1), table, Source::Newline(-1)];
        assert_eq!(lines(&s), ["", "  a   bbbc", "  dddd   ", "  😀  e  ", ""]);
    }

    #[test]
    fn modified_sources_see_resolved_names() {
        let mut naming = Naming::new();
        let ns = naming.namespace("ns", None, [], []);
        let n = naming.simple_name(["foo"], &Namer::new("id", str::to_owned, [""; 0], false), 1);
        naming.add(ns, n);
        let names = assign_names(&naming, &[ns]).unwrap();
        let s = sl![
            modify_source(|s| s.to_uppercase(), sl!["x_", n]),
            annotated(AnnotationData::issue("m"), sl!["!", n])
        ];
        let result = serialize_render_result(&s, &names, "    ").unwrap();
        assert_eq!(result.lines, ["X_FOO!foo"]);
        assert_eq!(result.annotations[0].span.start.column, 5);
        assert_eq!(result.annotations[0].span.end.column, 9);
        let two_lines = modify_source(str::to_owned, "a\nb");
        assert!(serialize_render_result(&two_lines, &names, "").is_err());
    }

    #[test]
    fn multi_words() {
        let mw = multi_word(" | ", vec!["a".into(), "b".into()]).unwrap();
        assert_eq!(lines(&paren_if_needed(mw)), ["(a | b)"]);
        let single = multi_word(" | ", vec!["a".into()]).unwrap();
        assert_eq!(lines(&paren_if_needed(single)), ["a"]);
        assert!(multi_word(" | ", vec![]).is_err());
    }
}

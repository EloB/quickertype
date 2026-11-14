//! JSDoc: `parseCommentsIntoDefinition` (typescript-json-schema) and the
//! TypeScript 5.9 documentation-comment rendering it consumes.
//!
//! TypeScript 7's `getDocumentationComment` returns one string with
//! `{@link X}` already rendered as `X`. TypeScript 5.9 returned display
//! parts that keep the link syntax (`{@link X}`), and typescript-json-schema
//! trims each `linkText` part separately. [`Generator::doc_parts`] rebuilds
//! those parts from the JSDoc nodes of the binary AST (port of
//! `getJsDocCommentsFromDeclarations`, `getDisplayPartsFromComment` and
//! `buildLinkParts` from TypeScript 5.9's `services`).
//!
//! Inherited documentation is TypeScript 5.9's too (`getDocumentationComment`
//! with `findBaseOfDeclaration`): a member whose own JSDoc has no text (none,
//! tags only, or empty), or has `@inheritDoc`, takes the documentation of the
//! property of its name on the first super type of its class or interface
//! that has one (`extends`, then `implements`), recursively. TypeScript 7
//! inherits only for members without JSDoc, through `extends`. The bases
//! come from the syntax tree and the compiler (`getTypeAtLocation`,
//! `getPropertyOfType`); TypeScript 7's own rendering is used only for
//! declarations whose comments TypeScript 5.9 reads elsewhere (a variable's
//! statement) and for base members in library files.

use std::rc::Rc;

use super::{Generator, SUB_DEFINITIONS, VALIDATION_KEYWORDS, get, in_table, set, text};
use crate::error::{Error, Result};
use crate::js::{self, Obj, Value};
use crate::tsc::api::Symbol;
use crate::tsc::ast::Node;
use crate::tsc::generated::{modifier_flags as mf, syntax_kind as sk};

/// A TypeScript 5.9 `SymbolDisplayPart`, reduced to what TJS reads.
#[derive(Clone, PartialEq)]
pub(super) struct Part {
    kind: &'static str,
    text: String,
}

fn part(kind: &'static str, text: impl Into<String>) -> Part {
    Part {
        kind,
        text: text.into(),
    }
}

/// `findLinkNameEnd`, on UTF-16 code units.
fn find_link_name_end(text: &[u16]) -> usize {
    let s = String::from_utf16_lossy(text);
    if s.find("://") == Some(0) {
        return text
            .iter()
            .position(|c| *c == b'|' as u16)
            .unwrap_or(text.len());
    }
    if s.starts_with("()") {
        return 2;
    }
    if text.first() == Some(&(b'<' as u16)) {
        let mut brackets = 0i32;
        for (i, c) in text.iter().enumerate() {
            if *c == b'<' as u16 {
                brackets += 1;
            }
            if *c == b'>' as u16 {
                brackets -= 1;
            }
            if brackets == 0 {
                return i + 1;
            }
        }
    }
    0
}

/// `skipSeparatorFromLinkText`.
fn skip_separator(text: &[u16]) -> &[u16] {
    if text.first() == Some(&(b'|' as u16)) {
        let mut pos = 1;
        while pos < text.len() && text[pos] == b' ' as u16 {
            pos += 1;
        }
        return &text[pos..];
    }
    text
}

impl Generator<'_> {
    /// `buildLinkParts(link, checker)`.
    fn link_parts(&self, link: &Node) -> Result<Vec<Part>> {
        let prefix = match link.kind() {
            sk::JSDocLink => "link",
            sk::JSDocLinkCode => "linkcode",
            _ => "linkplain",
        };
        let mut parts = vec![part("link", format!("{{@{prefix} "))];
        let text: Vec<u16> = link.text().unwrap_or_default().encode_utf16().collect();
        match link.named("name") {
            None => {
                if !text.is_empty() {
                    parts.push(part("linkText", String::from_utf16_lossy(&text)));
                }
            }
            Some(name_node) => {
                let symbol = self.s.symbol_at(&name_node)?;
                let suffix = find_link_name_end(&text);
                let mut name: Vec<u16> = name_node.get_text().encode_utf16().collect();
                name.extend_from_slice(&text[..suffix]);
                let rest = skip_separator(&text[suffix..]);
                let has_decl = symbol
                    .is_some_and(|s| !s.declarations.is_empty() || s.value_declaration.is_some());
                if has_decl {
                    parts.push(part("linkName", String::from_utf16_lossy(&name)));
                    if !rest.is_empty() {
                        parts.push(part("linkText", String::from_utf16_lossy(rest)));
                    }
                } else {
                    let separator = if suffix == 0
                        || (text.get(suffix) == Some(&(b'|' as u16))
                            && name.last() != Some(&(b' ' as u16)))
                    {
                        " "
                    } else {
                        ""
                    };
                    let mut all = name;
                    all.extend(separator.encode_utf16());
                    all.extend_from_slice(rest);
                    parts.push(part("linkText", String::from_utf16_lossy(&all)));
                }
            }
        }
        parts.push(part("link", "}"));
        Ok(parts)
    }

    /// `getDisplayPartsFromComment(comment, checker)`: the text and link
    /// parts of a JSDoc comment (a node list of `JSDocText` and links).
    fn comment_parts(&self, comment: &Node) -> Result<Vec<Part>> {
        let nodes = if comment.kind() == crate::tsc::ast::KIND_NODE_LIST {
            comment.raw_children()
        } else {
            vec![comment.clone()]
        };
        let mut parts = Vec::new();
        for n in nodes {
            if n.kind() == sk::JSDocText {
                parts.push(part("text", n.text().unwrap_or_default()));
            } else {
                parts.extend(self.link_parts(&n)?);
            }
        }
        Ok(parts)
    }

    /// `symbol.getDocumentationComment(checker)` as TypeScript 5.9 renders it.
    fn doc_parts(&self, symbol: &Symbol) -> Result<Vec<Part>> {
        self.documentation(symbol, Accessors::All)
    }

    /// `symbol.getDocumentationComment(checker)`, or with `Getters` or
    /// `Setters` the part of `getContextualDocumentationComment` that reads
    /// only those declarations; memoized per symbol, as TypeScript 5.9 does
    /// (empty while it is being computed, which ends cycles).
    fn documentation(&self, symbol: &Symbol, which: Accessors) -> Result<Vec<Part>> {
        let key = (symbol.id, which);
        if let Some(d) = self.docs.borrow().get(&key) {
            return Ok(d.clone());
        }
        self.docs.borrow_mut().insert(key, Vec::new());
        let d = self.documentation_of(symbol, which)?;
        self.docs.borrow_mut().insert(key, d.clone());
        Ok(d)
    }

    /// `getDocumentationComment(declarations, checker)` of the symbol's
    /// declarations (all, or the getters or the setters).
    fn documentation_of(&self, symbol: &Symbol, which: Accessors) -> Result<Vec<Part>> {
        let handles: Vec<_> = symbol
            .declarations
            .iter()
            .filter(|h| match which {
                Accessors::All => true,
                Accessors::Getters => h.kind == sk::GetAccessor,
                Accessors::Setters => h.kind == sk::SetAccessor,
            })
            .collect();
        let mut from_lib = false;
        for h in &handles {
            from_lib |= self.s.is_default_library(&h.path)?;
        }
        if from_lib {
            // A base member in a library file (`interface X extends Array<T>`):
            // its documentation as TypeScript 7 renders it, without reading
            // the library's syntax tree.
            let text = self.s.documentation_comment(symbol)?;
            return Ok(if text.is_empty() {
                Vec::new()
            } else {
                vec![part("text", text)]
            });
        }
        let mut decls = Vec::new();
        let mut seen = Vec::new();
        for h in handles {
            if !seen.contains(h) {
                seen.push(h.clone());
                decls.push(self.s.resolve(h)?);
            }
        }
        let (mut doc, inherit_doc) = self.own_documentation(&decls)?;
        if !doc.is_empty() && !inherit_doc {
            return Ok(doc);
        }
        if !decls.iter().all(comment_nodes_are_known) {
            // TypeScript 5.9 reads more JSDoc for these (a variable's
            // statement, a parameter's `@param`): TypeScript 7 knows where.
            if doc.is_empty() && which == Accessors::All {
                let text = self.s.documentation_comment(symbol)?;
                if !text.is_empty() {
                    doc.push(part("text", text));
                }
            }
            return Ok(doc);
        }
        // Inherited documentation (`findBaseOfDeclaration`).
        let mut seen_symbols = Vec::new();
        for decl in &decls {
            if let Some(inherited) = self.base_documentation(symbol, decl, &mut seen_symbols)? {
                doc = if doc.is_empty() {
                    inherited
                } else {
                    let mut joined = inherited;
                    joined.push(part("lineBreak", "\n"));
                    joined.extend(doc);
                    joined
                };
            }
        }
        Ok(doc)
    }

    /// `getJsDocCommentsFromDeclarations(declarations, checker)` for
    /// declarations whose comment-having nodes are their own JSDoc: the
    /// comment of each one's last JSDoc (with an `@inheritDoc` tag's), and
    /// the comments of the `@overload` tags of the ones before; whether one
    /// of them has an `@inheritDoc` tag.
    fn own_documentation(&self, decls: &[Node]) -> Result<(Vec<Part>, bool)> {
        let mut groups: Vec<Vec<Part>> = Vec::new();
        let mut inherit_doc = false;
        for decl in decls {
            self.own_jsdoc(decl, &mut groups, &mut inherit_doc)?;
            // A parameter's `@param` tags come after its own JSDoc.
            if decl.kind() == sk::Parameter {
                for tag in parameter_tags(decl) {
                    if let Some(c) = tag.named("comment") {
                        let parts = self.comment_parts(&c)?;
                        if !groups.contains(&parts) {
                            groups.push(parts);
                        }
                    }
                }
            }
        }
        let mut out = Vec::new();
        for (i, g) in groups.into_iter().enumerate() {
            if i > 0 {
                out.push(part("lineBreak", "\n"));
            }
            out.extend(g);
        }
        Ok((out, inherit_doc))
    }

    /// The groups of display parts of a declaration's own JSDoc: its last
    /// JSDoc's comment (with an `@inheritDoc` tag's), and the comments of
    /// the `@overload` tags of the ones before (`filterOwnedJSDocTags`);
    /// skipped when it has no comment and no `@inheritDoc`, or `@typedef`
    /// or `@callback` without `@param` or `@return`.
    fn own_jsdoc(
        &self,
        decl: &Node,
        groups: &mut Vec<Vec<Part>>,
        inherit_doc: &mut bool,
    ) -> Result<()> {
        let tag_name = |t: &Node| {
            t.named("tagName")
                .and_then(|n| n.text())
                .unwrap_or_default()
        };
        let jsdocs = decl.js_doc();
        let Some((last, earlier)) = jsdocs.split_last() else {
            return Ok(());
        };
        for jsdoc in earlier {
            for tag in jsdoc.named_list("tags") {
                if tag.kind() == sk::JSDocOverloadTag {
                    if let Some(c) = tag.named("comment") {
                        let parts = self.comment_parts(&c)?;
                        if !groups.contains(&parts) {
                            groups.push(parts);
                        }
                    }
                }
            }
        }
        let tags = last.named_list("tags");
        let is_inherit_doc = |t: &Node| matches!(tag_name(t).as_str(), "inheritDoc" | "inheritdoc");
        let inherit = tags
            .iter()
            .find(|t| t.kind() == sk::JSDocUnknownTag && is_inherit_doc(t));
        *inherit_doc |= tags.iter().any(is_inherit_doc);
        let comment = last.named("comment");
        let typedef = tags
            .iter()
            .any(|t| matches!(t.kind(), sk::JSDocTypedefTag | sk::JSDocCallbackTag))
            && !tags
                .iter()
                .any(|t| matches!(t.kind(), sk::JSDocParameterTag | sk::JSDocReturnTag));
        if comment.is_none() && inherit.is_none() || typedef {
            return Ok(());
        }
        let mut parts = match &comment {
            Some(c) => self.comment_parts(c)?,
            None => Vec::new(),
        };
        if let Some(c) = inherit.and_then(|t| t.named("comment")) {
            parts.extend(self.comment_parts(&c)?);
        }
        if !groups.contains(&parts) {
            groups.push(parts);
        }
        Ok(())
    }

    /// `findBaseOfDeclaration(checker, declaration, cb)` with the callback of
    /// `getDocumentationComment`: the first super type of the member's class
    /// or interface (`extends`, then `implements`) with a property of the
    /// member's name not met yet gives its documentation, contextual for an
    /// accessor.
    fn base_documentation(
        &self,
        symbol: &Symbol,
        decl: &Node,
        seen: &mut Vec<u64>,
    ) -> Result<Option<Vec<Part>>> {
        let mut container = decl.parent();
        if container
            .as_ref()
            .is_some_and(|c| c.kind() == sk::Constructor)
        {
            container = container.and_then(|c| c.parent());
        }
        let Some(container) = container else {
            return Ok(None);
        };
        // `checker.getPropertyOfType(type, declaration.symbol.name)` passes
        // the unescaped name where an escaped one is expected, so a name
        // with two leading underscores is never found.
        if symbol.name.starts_with("__") {
            return Ok(None);
        }
        let is_static = decl.modifier_flags() & mf::Static != 0;
        for node in super_type_nodes(&container) {
            let Some(base) = self.s.type_at(&node)? else {
                continue;
            };
            let ty = match is_static {
                true => match self.s.symbol_of_type(&base)? {
                    Some(sym) => self.s.type_of_symbol(&sym)?,
                    None => base,
                },
                false => base,
            };
            let Some(prop) = self.s.property_of_type(&ty, &symbol.name)? else {
                continue;
            };
            if seen.contains(&prop.id) {
                continue;
            }
            seen.push(prop.id);
            let contextual = match decl.kind() {
                sk::GetAccessor => Some(Accessors::Getters),
                sk::SetAccessor => Some(Accessors::Setters),
                _ => None,
            };
            let docs = match contextual {
                Some(which) => {
                    let d = self.documentation(&prop, which)?;
                    if d.is_empty() {
                        self.documentation(&prop, Accessors::All)?
                    } else {
                        d
                    }
                }
                None => self.documentation(&prop, Accessors::All)?,
            };
            return Ok(Some(docs));
        }
        Ok(None)
    }

    /// `parseCommentsIntoDefinition(symbol, definition, otherAnnotations)`.
    pub(super) fn parse_comments_into_definition(
        &mut self,
        symbol: Option<&Rc<Symbol>>,
        definition: &Obj,
        other_annotations: &Obj,
    ) -> Result<()> {
        let Some(symbol) = symbol else { return Ok(()) };
        if !self.is_from_default_lib(symbol)? {
            let parts = self.doc_parts(symbol)?;
            if !parts.is_empty() {
                let joined: String = parts
                    .iter()
                    .map(|p| {
                        let t = p.text.replace("\r\n", "\n");
                        if p.kind == "linkText" {
                            js::trim(&t).to_owned()
                        } else {
                            t
                        }
                    })
                    .collect();
                set(definition, "description", Value::str(js::trim(&joined)));
            }
        }
        for doc in self.s.js_doc_tags(symbol)? {
            let original_text = doc.text.clone().unwrap_or_default();
            let mut name = doc.name.clone();
            let mut text = original_text.clone();
            if let Some(rest) = name.strip_prefix("TJS-") {
                name = rest.to_owned();
                if text.is_empty() {
                    text = "true".into();
                }
            } else if name == "TJS" && text.starts_with('-') {
                match text::tjs_jsdoc(&original_text) {
                    Some((n, t)) => {
                        name = n.to_owned();
                        text = t.to_owned();
                    }
                    None => {
                        name = text::strip_leading_space_and_dashes(&text).to_owned();
                        text = "true".into();
                    }
                }
            }
            if in_table(SUB_DEFINITIONS, &name) {
                if let Some((k, v)) = text::group_jsdoc(&text) {
                    let value = if v.is_empty() {
                        Value::Bool(true)
                    } else {
                        parse_value(v)?
                    };
                    let merged =
                        js::spread(&[get(definition, &name).as_ref().and_then(Value::as_object)]);
                    merged.borrow_mut().define(k, value);
                    set(definition, &name, Value::Object(merged));
                    continue;
                }
            }
            if name.contains('.') {
                let parts: Vec<&str> = name.split('.').collect();
                if parts.len() == 2 && in_table(SUB_DEFINITIONS, parts[0]) {
                    let value = if text.is_empty() {
                        Value::Bool(true)
                    } else {
                        parse_value(&text)?
                    };
                    let merged = js::spread(&[get(definition, parts[0])
                        .as_ref()
                        .and_then(Value::as_object)]);
                    merged.borrow_mut().define(parts[1], value);
                    set(definition, parts[0], Value::Object(merged));
                }
            }
            if in_table(VALIDATION_KEYWORDS, &name) {
                set(definition, &name, parse_value(&text)?);
            } else {
                set(other_annotations, &doc.name, Value::Bool(true));
            }
        }
        Ok(())
    }
}

/// Which declarations of a symbol [`Generator::documentation`] reads.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub(super) enum Accessors {
    All,
    Getters,
    Setters,
}

/// Whether the port knows TypeScript 5.9's comment-having nodes of `decl`
/// (`getJSDocCommentsAndTags`): its own JSDoc for members of classes,
/// interfaces and type literals (a property without JSDoc on its
/// initializer) and for the declarations of interfaces, classes, type
/// aliases and enums; and for a constructor's parameter (a parameter
/// property) with a plain name, also the constructor's `@param` tags of
/// that name. For the others (`getNextJSDocCommentLocation` walks to a
/// variable statement, …) the port asks TypeScript 7.
pub(super) fn comment_nodes_are_known(decl: &Node) -> bool {
    let member_of = |kinds: &[u32]| decl.parent().is_some_and(|p| kinds.contains(&p.kind()));
    let containers = [
        sk::InterfaceDeclaration,
        sk::ClassDeclaration,
        sk::ClassExpression,
        sk::TypeLiteral,
    ];
    match decl.kind() {
        sk::PropertySignature
        | sk::MethodSignature
        | sk::MethodDeclaration
        | sk::GetAccessor
        | sk::SetAccessor => member_of(&containers),
        sk::PropertyDeclaration => {
            member_of(&containers)
                && decl
                    .named("initializer")
                    .is_none_or(|i| i.js_doc().is_empty())
        }
        sk::Parameter => {
            member_of(&[sk::Constructor])
                && decl
                    .named("name")
                    .is_some_and(|n| n.kind() == sk::Identifier)
                && decl
                    .named("initializer")
                    .is_none_or(|i| i.js_doc().is_empty())
        }
        sk::InterfaceDeclaration
        | sk::ClassDeclaration
        | sk::TypeAliasDeclaration
        | sk::EnumDeclaration
        | sk::EnumMember => true,
        _ => false,
    }
}

/// `getJSDocParameterTags(param)`: the `@param` tags of the parameter's
/// function (its last JSDoc's) that name it.
fn parameter_tags(param: &Node) -> Vec<Node> {
    let name = param.named("name").and_then(|n| n.text());
    let Some(function) = param.parent() else {
        return Vec::new();
    };
    let Some(last) = function.js_doc().pop() else {
        return Vec::new();
    };
    last.named_list("tags")
        .into_iter()
        .filter(|t| {
            t.kind() == sk::JSDocParameterTag
                && t.named("name")
                    .is_some_and(|n| n.kind() == sk::Identifier && n.text() == name)
        })
        .collect()
}

/// `getAllSuperTypeNodes(node)`: an interface's `extends` types; a class's
/// `extends` type, then its `implements` types; nothing for others.
pub(super) fn super_type_nodes(node: &Node) -> Vec<Node> {
    let clauses = node.named_list("heritageClauses");
    let of = |token: u32| -> Vec<Node> {
        clauses
            .iter()
            .filter(|c| c.token() == Some(token))
            .flat_map(|c| c.named_list("types"))
            .collect()
    };
    match node.kind() {
        sk::InterfaceDeclaration => of(sk::ExtendsKeyword),
        sk::ClassDeclaration | sk::ClassExpression => {
            let mut out: Vec<Node> = of(sk::ExtendsKeyword).into_iter().take(1).collect();
            out.extend(of(sk::ImplementsKeyword));
            out
        }
        _ => Vec::new(),
    }
}

/// `parseValue(symbol, key, value)`: JSON if it parses, else the string.
/// `require("…")` values load a JavaScript module in the original, which this
/// port cannot do.
fn parse_value(value: &str) -> Result<Value> {
    if text::is_require(value) {
        return Err(Error::Generator(format!(
            "JSDoc values that require() a module are not supported by quicktype's native TypeScript input: {value}"
        )));
    }
    Ok(js::parse_json(value).unwrap_or_else(|| Value::str(value)))
}

#[cfg(test)]
mod tests {
    use super::*;

    fn u(s: &str) -> Vec<u16> {
        s.encode_utf16().collect()
    }

    #[test]
    fn link_name_end() {
        assert_eq!(find_link_name_end(&u("://example.com|x")), 14);
        assert_eq!(find_link_name_end(&u("() rest")), 2);
        assert_eq!(find_link_name_end(&u("<T<U>> x")), 6);
        assert_eq!(find_link_name_end(&u(" plain")), 0);
        assert_eq!(skip_separator(&u("|  text")), u("text"));
    }
}

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

use std::rc::Rc;

use super::{Generator, SUB_DEFINITIONS, VALIDATION_KEYWORDS, get, set, text};
use crate::error::{Error, Result};
use crate::js::{self, Obj, Value};
use crate::tsc::api::Symbol;
use crate::tsc::ast::Node;
use crate::tsc::generated::syntax_kind as sk;

/// A TypeScript 5.9 `SymbolDisplayPart`, reduced to what TJS reads.
#[derive(Clone, PartialEq)]
struct Part {
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

    /// `symbol.getDocumentationComment(checker)` as TypeScript 5.9 renders it.
    fn doc_parts(&self, symbol: &Symbol) -> Result<Vec<Part>> {
        let mut groups: Vec<Vec<Part>> = Vec::new();
        let mut seen = Vec::new();
        for h in &symbol.declarations {
            if seen.contains(h) {
                continue;
            }
            seen.push(h.clone());
            let decl = self.s.resolve(h)?;
            for jsdoc in decl.js_doc() {
                let Some(comment) = jsdoc.named("comment") else {
                    continue;
                };
                let mut parts = Vec::new();
                let nodes = if comment.kind() == crate::tsc::ast::KIND_NODE_LIST {
                    comment.raw_children()
                } else {
                    vec![comment]
                };
                for n in nodes {
                    if n.kind() == sk::JSDocText {
                        parts.push(part("text", n.text().unwrap_or_default()));
                    } else {
                        parts.extend(self.link_parts(&n)?);
                    }
                }
                if !groups.contains(&parts) {
                    groups.push(parts);
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
        if out.is_empty() {
            // Inherited documentation (`findBaseOfDeclaration`): the checker
            // already resolves it; it has no link syntax to preserve.
            let inherited = self.s.documentation_comment(symbol)?;
            if !inherited.is_empty() {
                out.push(part("text", inherited));
            }
        }
        Ok(out)
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
            if SUB_DEFINITIONS.contains(&name.as_str()) {
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
                if parts.len() == 2 && SUB_DEFINITIONS.contains(&parts[0]) {
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
            if VALIDATION_KEYWORDS.contains(&name.as_str()) {
                set(definition, &name, parse_value(&text)?);
            } else {
                set(other_annotations, &doc.name, Value::Bool(true));
            }
        }
        Ok(())
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

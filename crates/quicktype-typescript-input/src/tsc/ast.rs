//! Reader for the binary AST that `getSourceFile` and `typeToTypeNode`
//! return (protocol version 5).
//!
//! Port of `typescript/dist/api/node/{protocol,node,node.infrastructure,
//! node.generated}.js` (TypeScript 7.0.2). All integers are little-endian.
//! The 44-byte header holds the offsets of the string-offset table (24), the
//! string data (28), the extended data (32) and the node array (40). Nodes
//! are 28-byte records `kind, pos, end, next, parent, data, flags` in
//! pre-order; index 0 is a nil sentinel and index 1 the root. A node's
//! children start right after it (when that node's parent is it) and are
//! chained by `next`; `kind == 0xFFFFFFFF` is a node list. Strings are
//! WTF-8, and `pos`/`end` count UTF-16 code units of the source text.

use std::cell::OnceCell;
use std::rc::Rc;

use super::generated::{child_properties, modifier_flags as mf, node_flags, syntax_kind as sk};

const HEADER_SIZE: usize = 44;
const NODE_LEN: usize = 28;
/// `kind` of a synthetic node-list container.
pub const KIND_NODE_LIST: u32 = 0xFFFF_FFFF;
const DATA_TYPE_MASK: u32 = 0xC000_0000;
const DATA_TYPE_CHILDREN: u32 = 0;
const INDEX_MASK: u32 = 0x00FF_FFFF;

/// A decoded source file (or synthetic node tree).
pub struct SourceFile {
    bytes: Vec<u8>,
    str_offsets: usize,
    strings: usize,
    extended: usize,
    nodes: usize,
    count: usize,
    text16: OnceCell<Vec<u16>>,
}

/// A node of a [`SourceFile`].
#[derive(Clone)]
pub struct Node {
    sf: Rc<SourceFile>,
    index: usize,
}

impl std::fmt::Debug for Node {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "Node({}.{})", self.index, self.kind())
    }
}

/// Decodes WTF-8 (UTF-8 that may encode lone surrogates) to UTF-16 units.
fn wtf8_to_utf16(bytes: &[u8]) -> Vec<u16> {
    let mut out = Vec::with_capacity(bytes.len());
    let mut i = 0;
    while i < bytes.len() {
        let b0 = bytes[i] as u32;
        let cont = |k: usize| bytes.get(i + k).map_or(0, |b| (*b as u32) & 0x3f);
        let (cp, len) = if b0 < 0x80 {
            (b0, 1)
        } else if b0 >> 5 == 0b110 {
            (((b0 & 0x1f) << 6) | cont(1), 2)
        } else if b0 >> 4 == 0b1110 {
            (((b0 & 0x0f) << 12) | (cont(1) << 6) | cont(2), 3)
        } else if b0 >> 3 == 0b11110 {
            (
                ((b0 & 0x07) << 18) | (cont(1) << 12) | (cont(2) << 6) | cont(3),
                4,
            )
        } else {
            (0xfffd, 1)
        };
        if cp >= 0x1_0000 {
            let v = cp - 0x1_0000;
            out.push(0xd800 | (v >> 10) as u16);
            out.push(0xdc00 | (v & 0x3ff) as u16);
        } else {
            out.push(cp as u16);
        }
        i += len;
    }
    out
}

impl SourceFile {
    /// Decodes a binary AST response.
    pub fn parse(bytes: Vec<u8>) -> Option<Rc<SourceFile>> {
        if bytes.len() < HEADER_SIZE {
            return None;
        }
        let mut sf = SourceFile {
            bytes,
            str_offsets: 0,
            strings: 0,
            extended: 0,
            nodes: 0,
            count: 0,
            text16: OnceCell::new(),
        };
        sf.str_offsets = sf.u32_at(24) as usize;
        sf.strings = sf.u32_at(28) as usize;
        sf.extended = sf.u32_at(32) as usize;
        sf.nodes = sf.u32_at(40) as usize;
        if sf.nodes > sf.bytes.len() {
            return None;
        }
        sf.count = (sf.bytes.len() - sf.nodes) / NODE_LEN;
        (sf.count > 1).then(|| Rc::new(sf))
    }

    fn u32_at(&self, off: usize) -> u32 {
        self.bytes
            .get(off..off + 4)
            .map_or(0, |b| u32::from_le_bytes([b[0], b[1], b[2], b[3]]))
    }

    fn field(&self, index: usize, field: usize) -> u32 {
        if index >= self.count {
            return 0;
        }
        self.u32_at(self.nodes + index * NODE_LEN + field * 4)
    }

    fn string_units(&self, idx: u32) -> Vec<u16> {
        let at = self.str_offsets + idx as usize * 4;
        let (start, end) = (self.u32_at(at) as usize, self.u32_at(at + 4) as usize);
        let (start, end) = (self.strings + start, self.strings + end);
        self.bytes
            .get(start..end)
            .map(wtf8_to_utf16)
            .unwrap_or_default()
    }

    fn string(&self, idx: u32) -> String {
        String::from_utf16_lossy(&self.string_units(idx))
    }

    /// The root node (the `SourceFile`, or the synthetic node of a
    /// `typeToTypeNode` result).
    pub fn root(self: &Rc<Self>) -> Node {
        Node {
            sf: Rc::clone(self),
            index: 1,
        }
    }

    /// The node at `index`, if it exists.
    pub fn node(self: &Rc<Self>, index: usize) -> Option<Node> {
        (index >= 1 && index < self.count).then(|| Node {
            sf: Rc::clone(self),
            index,
        })
    }

    fn root_ext(&self) -> usize {
        self.extended + (self.field(1, 5) & INDEX_MASK) as usize
    }

    /// The canonical path, as used in node handles.
    pub fn path(&self) -> String {
        self.string(self.u32_at(self.root_ext() + 8))
    }

    /// The source text in UTF-16 code units (what `pos`/`end` index).
    pub fn text16(&self) -> &[u16] {
        self.text16
            .get_or_init(|| self.string_units(self.u32_at(self.root_ext())))
    }
}

/// `modifierToFlag` from `node.infrastructure.js`.
fn modifier_to_flag(kind: u32) -> u32 {
    match kind {
        sk::StaticKeyword => mf::Static,
        sk::PublicKeyword => mf::Public,
        sk::ProtectedKeyword => mf::Protected,
        sk::PrivateKeyword => mf::Private,
        sk::AbstractKeyword => mf::Abstract,
        sk::AccessorKeyword => mf::Accessor,
        sk::ExportKeyword => mf::Export,
        sk::DeclareKeyword => mf::Ambient,
        sk::ConstKeyword => mf::Const,
        sk::DefaultKeyword => mf::Default,
        sk::AsyncKeyword => mf::Async,
        sk::ReadonlyKeyword => mf::Readonly,
        sk::OverrideKeyword => mf::Override,
        sk::InKeyword => mf::In,
        sk::OutKeyword => mf::Out,
        sk::Decorator => mf::Decorator,
        _ => mf::None,
    }
}

fn is_line_break(c: u16) -> bool {
    matches!(c, 0x0a | 0x0d | 0x2028 | 0x2029)
}

fn is_white_space_single_line(c: u16) -> bool {
    matches!(
        c,
        0x09 | 0x0b | 0x0c | 0x20 | 0x85 | 0xa0 | 0x1680 | 0x2000
            ..=0x200b | 0x202f | 0x205f | 0x3000 | 0xfeff
    )
}

/// `skipTrivia(text, pos)`: whitespace, comments and a leading shebang.
fn skip_trivia(text: &[u16], mut pos: usize) -> usize {
    if pos == 0 && text.starts_with(&[b'#' as u16, b'!' as u16]) {
        while pos < text.len() && !is_line_break(text[pos]) {
            pos += 1;
        }
    }
    while pos < text.len() {
        let c = text[pos];
        if is_line_break(c) || is_white_space_single_line(c) {
            pos += 1;
        } else if c == b'/' as u16 && text.get(pos + 1) == Some(&(b'/' as u16)) {
            pos += 2;
            while pos < text.len() && !is_line_break(text[pos]) {
                pos += 1;
            }
        } else if c == b'/' as u16 && text.get(pos + 1) == Some(&(b'*' as u16)) {
            pos += 2;
            while pos < text.len()
                && !(text[pos] == b'*' as u16 && text.get(pos + 1) == Some(&(b'/' as u16)))
            {
                pos += 1;
            }
            pos = (pos + 2).min(text.len());
        } else {
            break;
        }
    }
    pos
}

impl Node {
    /// The node's index in its file.
    pub fn index(&self) -> usize {
        self.index
    }

    /// `SyntaxKind` (or [`KIND_NODE_LIST`]).
    pub fn kind(&self) -> u32 {
        self.sf.field(self.index, 0)
    }

    /// Start of the node including leading trivia, in UTF-16 units.
    pub fn pos(&self) -> usize {
        self.sf.field(self.index, 1) as usize
    }

    /// End of the node, in UTF-16 units.
    pub fn end(&self) -> usize {
        self.sf.field(self.index, 2) as usize
    }

    fn next(&self) -> usize {
        self.sf.field(self.index, 3) as usize
    }

    fn data(&self) -> u32 {
        self.sf.field(self.index, 5)
    }

    /// `NodeFlags`.
    pub fn flags(&self) -> u32 {
        self.sf.field(self.index, 6)
    }

    /// The node's file.
    pub fn source_file(&self) -> &Rc<SourceFile> {
        &self.sf
    }

    /// The node handle the checker API takes: `index.kind.path`.
    pub fn handle(&self) -> String {
        format!("{}.{}.{}", self.index, self.kind(), self.sf.path())
    }

    /// The parent node, skipping node-list containers like the JS client.
    pub fn parent(&self) -> Option<Node> {
        let mut p = self.sf.field(self.index, 4) as usize;
        while p != self.index && p != 0 && self.sf.field(p, 0) == KIND_NODE_LIST {
            p = self.sf.field(p, 4) as usize;
        }
        (p != 0 && p != self.index).then(|| Node {
            sf: Rc::clone(&self.sf),
            index: p,
        })
    }

    fn has_children(&self) -> bool {
        self.index + 1 < self.sf.count && self.sf.field(self.index + 1, 4) as usize == self.index
    }

    /// Direct children in order, node lists and JSDoc included.
    pub fn raw_children(&self) -> Vec<Node> {
        let mut out = Vec::new();
        if self.has_children() {
            let mut i = self.index + 1;
            while i != 0 && i < self.sf.count && out.len() < self.sf.count {
                let n = Node {
                    sf: Rc::clone(&self.sf),
                    index: i,
                };
                i = n.next();
                out.push(n);
            }
        }
        out
    }

    /// `forEachChild`: children with lists flattened and JSDoc skipped.
    pub fn children(&self) -> Vec<Node> {
        let mut out = Vec::new();
        for c in self.raw_children() {
            if c.kind() == KIND_NODE_LIST {
                out.extend(c.raw_children());
            } else if c.kind() != sk::JSDoc {
                out.push(c);
            }
        }
        out
    }

    /// The JSDoc comments attached to this node.
    pub fn js_doc(&self) -> Vec<Node> {
        self.raw_children()
            .into_iter()
            .filter(|c| c.kind() == sk::JSDoc)
            .collect()
    }

    /// A named child (`getNamedChild`), possibly a node list.
    pub fn named(&self, property: &str) -> Option<Node> {
        let order = child_properties(self.kind())
            .iter()
            .position(|p| *p == property)?;
        if !self.has_children() || order >= 8 {
            return None;
        }
        let mask = if self.data() & DATA_TYPE_MASK == DATA_TYPE_CHILDREN {
            self.data() & 0xff
        } else {
            0xff
        };
        if mask & (1 << order) == 0 {
            return None;
        }
        let missing = (!(mask | ((0xff << order) & 0xff)) & 0xff).count_ones() as usize;
        let mut i = self.index + 1;
        for _ in 0..order - missing {
            i = self.sf.field(i, 3) as usize;
            if i == 0 {
                return None;
            }
        }
        self.sf.node(i)
    }

    /// The elements of a named child that is a list (`members`,
    /// `parameters`, …); a single node counts as one element.
    pub fn named_list(&self, property: &str) -> Vec<Node> {
        match self.named(property) {
            Some(n) if n.kind() == KIND_NODE_LIST => n.raw_children(),
            Some(n) => vec![n],
            None => Vec::new(),
        }
    }

    /// The `text` of identifiers, literals and JSDoc text nodes.
    pub fn text(&self) -> Option<String> {
        match self.kind() {
            sk::Identifier
            | sk::PrivateIdentifier
            | sk::JsxText
            | sk::JSDocText
            | sk::JSDocLink
            | sk::JSDocLinkPlain
            | sk::JSDocLinkCode => Some(self.sf.string(self.data() & INDEX_MASK)),
            sk::StringLiteral
            | sk::NumericLiteral
            | sk::BigIntLiteral
            | sk::RegularExpressionLiteral
            | sk::NoSubstitutionTemplateLiteral
            | sk::TemplateHead
            | sk::TemplateMiddle
            | sk::TemplateTail => {
                let ext = self.sf.extended + (self.data() & INDEX_MASK) as usize;
                Some(self.sf.string(self.sf.u32_at(ext)))
            }
            _ => None,
        }
    }

    /// `getText()`: the source text from the first token to the end.
    pub fn get_text(&self) -> String {
        let text = self.sf.text16();
        let start = skip_trivia(text, self.pos().min(text.len()));
        let end = self.end().min(text.len()).max(start);
        String::from_utf16_lossy(&text[start..end])
    }

    /// `operator` of prefix-unary expressions and type operators, which the
    /// format packs into the top byte of `data`.
    pub fn operator(&self) -> Option<u32> {
        let bits = self.data() >> 24;
        match self.kind() {
            sk::PrefixUnaryExpression => Some(match bits & 0x7 {
                1 => sk::MinusToken,
                2 => sk::TildeToken,
                3 => sk::ExclamationToken,
                4 => sk::PlusPlusToken,
                5 => sk::MinusMinusToken,
                _ => sk::PlusToken,
            }),
            sk::TypeOperator => Some(match bits & 0x3 {
                1 => sk::ReadonlyKeyword,
                2 => sk::UniqueKeyword,
                _ => sk::KeyOfKeyword,
            }),
            _ => None,
        }
    }

    /// `ModifierFlags` of the node's own `modifiers`.
    pub fn modifier_flags(&self) -> u32 {
        self.named_list("modifiers")
            .iter()
            .fold(mf::None, |acc, m| acc | modifier_to_flag(m.kind()))
    }

    /// Whether this is a declaration file (`SourceFile` flagged ambient).
    pub fn is_declaration_file(&self) -> bool {
        self.flags() & node_flags::Ambient != 0
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn wtf8_keeps_lone_surrogates_and_astral_characters() {
        assert_eq!(wtf8_to_utf16("a😀".as_bytes()), [0x61, 0xd83d, 0xde00]);
        assert_eq!(wtf8_to_utf16(&[0xed, 0xa0, 0x80]), [0xd800]);
        assert_eq!(wtf8_to_utf16("\u{feff}x".as_bytes()), [0xfeff, 0x78]);
    }

    #[test]
    fn trivia_is_skipped() {
        let t: Vec<u16> = " /* c */ // d\n  x".encode_utf16().collect();
        assert_eq!(skip_trivia(&t, 0), 16);
    }

    #[test]
    fn short_input_is_rejected() {
        assert!(SourceFile::parse(vec![0; 10]).is_none());
    }
}

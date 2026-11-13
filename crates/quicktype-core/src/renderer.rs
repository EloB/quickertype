//! Port of `packages/quicktype-core/src/Renderer.ts`.
//!
//! The emit model shared by every renderer: an [`EmitContext`] collects the
//! items of the current file, blank lines are requested with
//! [`ensure_blank_line`](RendererCore::ensure_blank_line) and only
//! materialized before the next item, and indentation changes are recorded
//! on the newline that ended the previous line.
//!
//! The TypeScript abstract class `Renderer` is split in two:
//!
//! - [`RendererCore`], the state and every emit method that doesn't take a
//!   callback. Renderers own one (inside their
//!   [`ConvenienceRendererCore`](crate::convenience_renderer::ConvenienceRendererCore)).
//! - The methods that call back into the renderer (`indent`,
//!   `gatherSource`, `forEach*`, `render`) live on the
//!   [`ConvenienceRendererExt`](crate::convenience_renderer::ConvenienceRendererExt)
//!   trait, because the callback needs the whole renderer.

use std::collections::HashMap;

use indexmap::IndexMap;

use crate::annotation::AnnotationData;
use crate::messages::{ErrorKind, QuickTypeError, Result};
use crate::naming::Names;
use crate::source::{Source, annotated};
use crate::support::comments::Comment;
use crate::support::support::{assert, console_log, panic};
use crate::target_language::TargetLanguage;
use crate::ty::type_graph::TypeGraph;

/// `RenderResult`: the files (in the order they were finished) and the
/// assigned names.
#[derive(Debug)]
pub struct RenderResult {
    /// File name to contents.
    pub sources: IndexMap<String, Source>,
    /// The names the sources refer to.
    pub names: Names,
}

/// `BlankLinePosition`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum BlankLinePosition {
    /// `"none"`.
    None,
    /// `"interposing"`: between items.
    Interposing,
    /// `"leading"`: before the first item.
    Leading,
    /// `"leading-and-interposing"`.
    LeadingAndInterposing,
}

/// `BlankLineConfig`: a position and a count (TS `position` or
/// `[position, count]`; the count defaults to 1).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct BlankLineConfig {
    /// Where to put blank lines.
    pub position: BlankLinePosition,
    /// How many.
    pub count: usize,
}

impl From<BlankLinePosition> for BlankLineConfig {
    fn from(position: BlankLinePosition) -> Self {
        BlankLineConfig { position, count: 1 }
    }
}

impl From<(BlankLinePosition, usize)> for BlankLineConfig {
    fn from((position, count): (BlankLinePosition, usize)) -> Self {
        BlankLineConfig { position, count }
    }
}

impl BlankLineConfig {
    /// The `(interposing, leading)` blank line counts of
    /// `forEachWithBlankLines`.
    pub fn counts(self) -> (usize, usize) {
        let interposing = matches!(
            self.position,
            BlankLinePosition::Interposing | BlankLinePosition::LeadingAndInterposing
        );
        let leading = matches!(
            self.position,
            BlankLinePosition::Leading | BlankLinePosition::LeadingAndInterposing
        );
        (
            if interposing { self.count } else { 0 },
            if leading { self.count } else { 0 },
        )
    }
}

/// `ForEachPosition`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum ForEachPosition {
    /// The first of several items.
    First,
    /// The last of several items.
    Last,
    /// Neither first nor last.
    Middle,
    /// The only item.
    Only,
}

impl ForEachPosition {
    /// The position of item `index` of `len` (TS `iterableForEach`).
    pub fn of(index: usize, len: usize) -> ForEachPosition {
        if len == 1 {
            ForEachPosition::Only
        } else if index == 0 {
            ForEachPosition::First
        } else if index == len - 1 {
            ForEachPosition::Last
        } else {
            ForEachPosition::Middle
        }
    }
}

/// `lineIndentation(line)`: the indentation of a line in spaces (a tab
/// advances to the next multiple of four plus four, as in TypeScript's
/// `(indent / 4 + 1) * 4`) and the rest of the line, or `None` if the line
/// is blank.
fn line_indentation(line: &str) -> (usize, Option<&str>) {
    let mut indent = 0;
    for (i, b) in line.bytes().enumerate() {
        match b {
            b' ' => indent += 1,
            // `(indent / 4 + 1) * 4` in floating point is `indent + 4`.
            b'\t' => indent += 4,
            _ => return (indent, Some(&line[i..])),
        }
    }
    (0, None)
}

/// `RenderContext`: what a renderer renders.
#[derive(Clone, Copy, Debug)]
pub struct RenderContext<'a> {
    /// The type graph.
    pub type_graph: &'a TypeGraph,
    /// Comments to put at the top instead of the language's default
    /// header (`leadingComments`).
    pub leading_comments: Option<&'a [Comment]>,
}

/// `EmitContext`: the items of the file being emitted.
#[derive(Clone, Debug)]
pub struct EmitContext {
    items: Vec<Source>,
    last_newline: Option<usize>,
    num_blank_lines_needed: usize,
    prevent_blank_line: bool,
    /// Whether a finished file refers to this context (it can be reopened
    /// and its items are a file's contents).
    finished: bool,
}

impl Default for EmitContext {
    fn default() -> Self {
        EmitContext::new()
    }
}

impl EmitContext {
    /// A new, empty context. Blank lines are prevented at the start of a
    /// file.
    pub fn new() -> Self {
        EmitContext {
            items: Vec::new(),
            last_newline: None,
            num_blank_lines_needed: 0,
            prevent_blank_line: true,
            finished: false,
        }
    }

    /// `isEmpty`.
    pub fn is_empty(&self) -> bool {
        self.items.is_empty()
    }

    /// `source`: the emitted items.
    pub fn source(&self) -> &[Source] {
        &self.items
    }

    fn push_item(&mut self, item: Source) {
        self.items.push(item);
        self.prevent_blank_line = false;
    }

    fn emit_newline(&mut self) {
        self.push_item(Source::Newline(0));
        self.last_newline = Some(self.items.len() - 1);
    }

    fn emit_item(&mut self, item: Source) {
        if !self.is_empty() {
            for _ in 0..self.num_blank_lines_needed {
                self.emit_newline();
            }
        }
        self.num_blank_lines_needed = 0;
        self.push_item(item);
    }

    /// `containsItem(item)`: JavaScript `===` against every item. Only
    /// primitive strings ([`Source::Text`] items) compare by value and
    /// names by identity; arrays ([`Source::Sequence`], e.g. from
    /// [`sl!`](crate::sl) even with one part) and every other source object
    /// are fresh and never equal.
    fn contains_item(&self, item: &Source) -> bool {
        match item {
            Source::Text(s) => self
                .items
                .iter()
                .any(|i| matches!(i, Source::Text(t) if t == s)),
            Source::Name(n) => self
                .items
                .iter()
                .any(|i| matches!(i, Source::Name(m) if m == n)),
            _ => false,
        }
    }

    fn ensure_blank_line(&mut self, num_blank_lines: usize) {
        if self.prevent_blank_line {
            return;
        }
        self.num_blank_lines_needed = self.num_blank_lines_needed.max(num_blank_lines);
    }

    fn prevent_blank_line(&mut self) {
        self.num_blank_lines_needed = 0;
        self.prevent_blank_line = true;
    }

    fn change_indent(&mut self, offset: i32) -> Result<()> {
        let Some(index) = self.last_newline else {
            return panic("Cannot change indent for the first line");
        };
        if let Source::Newline(change) = &mut self.items[index] {
            *change += offset;
        }
        Ok(())
    }
}

/// The state of a renderer (the fields of TS `Renderer`) and its emit
/// methods.
pub struct RendererCore<'a> {
    target_language: &'a dyn TargetLanguage,
    type_graph: &'a TypeGraph,
    leading_comments: Option<&'a [Comment]>,
    names: Option<Names>,
    /// Every emit context: finished files keep theirs here, because a file
    /// can be reopened (`initializeEmitContextForFilename`).
    contexts: Vec<EmitContext>,
    current: usize,
    /// File name to (context, number of items when it was finished). The
    /// prefix is the TS snapshot array; reading it at the end also sees
    /// later indentation changes on its last newline, as the shared newline
    /// object does in TypeScript.
    finished_files: IndexMap<String, (usize, usize)>,
    finished_emit_contexts: HashMap<String, usize>,
}

impl std::fmt::Debug for RendererCore<'_> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("RendererCore")
            .field("target_language", &self.target_language.name())
            .field("finished_files", &self.finished_files.keys())
            .finish_non_exhaustive()
    }
}

impl<'a> RendererCore<'a> {
    /// `new Renderer(targetLanguage, renderContext)`.
    pub fn new(target_language: &'a dyn TargetLanguage, render_context: RenderContext<'a>) -> Self {
        RendererCore {
            target_language,
            type_graph: render_context.type_graph,
            leading_comments: render_context.leading_comments,
            names: None,
            contexts: vec![EmitContext::new()],
            current: 0,
            finished_files: IndexMap::new(),
            finished_emit_contexts: HashMap::new(),
        }
    }

    /// `targetLanguage`.
    pub fn target_language(&self) -> &'a dyn TargetLanguage {
        self.target_language
    }

    /// `typeGraph`.
    pub fn type_graph(&self) -> &'a TypeGraph {
        self.type_graph
    }

    /// `leadingComments`.
    pub fn leading_comments(&self) -> Option<&'a [Comment]> {
        self.leading_comments
    }

    /// `names`: errors before naming.
    pub fn names(&self) -> Result<&Names> {
        match &self.names {
            Some(names) => Ok(names),
            None => panic("Names accessed before they were assigned"),
        }
    }

    pub(crate) fn set_names(&mut self, names: Names) {
        self.names = Some(names);
    }

    fn ctx(&mut self) -> &mut EmitContext {
        &mut self.contexts[self.current]
    }

    /// The current emit context.
    pub fn emit_context(&self) -> &EmitContext {
        &self.contexts[self.current]
    }

    /// `ensureBlankLine(numBlankLines)`.
    pub fn ensure_blank_line(&mut self, num_blank_lines: usize) {
        self.ctx().ensure_blank_line(num_blank_lines);
    }

    /// `preventBlankLine()`.
    pub fn prevent_blank_line(&mut self) {
        self.ctx().prevent_blank_line();
    }

    /// `emitItem(item)`.
    pub fn emit_item(&mut self, item: impl Into<Source>) {
        self.ctx().emit_item(item.into());
    }

    /// `emitItemOnce(item)`: emits unless an equal item (see
    /// [`emit_line_once`](Self::emit_line_once)) was emitted before.
    pub fn emit_item_once(&mut self, item: impl Into<Source>) -> bool {
        let item = item.into();
        if self.ctx().contains_item(&item) {
            return false;
        }
        self.ctx().emit_item(item);
        true
    }

    /// `emitLineOnce(...lineParts)`: like
    /// [`emit_line_parts`](Self::emit_line_parts), unless the line's item
    /// was already emitted in this file. Only single-part lines can match:
    /// a string equal to an earlier string item, or the same name.
    pub fn emit_line_once(&mut self, line_parts: Vec<Source>) {
        let mut line_emitted = true;
        let mut parts = line_parts;
        if parts.len() == 1 {
            line_emitted = self.emit_item_once(parts.remove(0));
        } else if parts.len() > 1 {
            line_emitted = self.emit_item_once(Source::Sequence(parts));
        }
        if line_emitted {
            self.ctx().emit_newline();
        }
    }

    /// `emitLine(line)` with exactly one part: the item, then a newline.
    /// Use [`sl!`](crate::sl) for several parts.
    pub fn emit_line(&mut self, line: impl Into<Source>) {
        self.ctx().emit_item(line.into());
        self.ctx().emit_newline();
    }

    /// `emitLine(...lineParts)` with any number of parts: no parts emits
    /// only a newline (pending blank lines stay pending), one part is the
    /// item itself, several are one sequence item.
    pub fn emit_line_parts(&mut self, line_parts: Vec<Source>) {
        let mut parts = line_parts;
        if parts.len() == 1 {
            self.ctx().emit_item(parts.remove(0));
        } else if parts.len() > 1 {
            self.ctx().emit_item(Source::Sequence(parts));
        }
        self.ctx().emit_newline();
    }

    /// A newline without an item (TS `emitLine()` with no arguments).
    pub fn emit_newline(&mut self) {
        self.ctx().emit_newline();
    }

    /// `emitMultiline(linesString)`: emits the lines of `lines_string`,
    /// turning each multiple of four leading spaces into an indentation
    /// level. Errors if a line's indentation is not a multiple of four.
    pub fn emit_multiline(&mut self, lines_string: &str) -> Result<()> {
        let mut lines = lines_string.split('\n');
        let Some(first) = lines.next() else {
            return Ok(());
        };
        self.emit_line(first);
        let mut current_indent: i64 = 0;
        for line in lines {
            let (indent, text) = line_indentation(line);
            assert(indent % 4 == 0, "Indentation is not a multiple of 4.")?;
            match text {
                Some(text) => {
                    let new_indent = (indent / 4) as i64;
                    self.change_indent((new_indent - current_indent) as i32)?;
                    current_indent = new_indent;
                    self.emit_line(text);
                }
                None => self.ctx().emit_newline(),
            }
        }
        if current_indent != 0 {
            self.change_indent(-(current_indent as i32))?;
        }
        Ok(())
    }

    /// Starts `gatherSource`: subsequent emits go to a fresh context.
    /// Returns the context to restore with [`end_gather`](Self::end_gather).
    pub fn begin_gather(&mut self) -> usize {
        let saved = self.current;
        self.contexts.push(EmitContext::new());
        self.current = self.contexts.len() - 1;
        saved
    }

    /// Ends `gatherSource`: returns the items of the current context and
    /// makes `saved` current again.
    ///
    /// The gather context is freed, unless it is a finished file (the
    /// gatherer reopened one), whose items are copied.
    pub fn end_gather(&mut self, saved: usize) -> Vec<Source> {
        let index = self.current;
        let items = if self.contexts[index].finished {
            self.contexts[index].items.clone()
        } else {
            let items = std::mem::take(&mut self.contexts[index].items);
            if index == self.contexts.len() - 1 && index != saved {
                self.contexts.pop();
            }
            items
        };
        self.current = saved;
        items
    }

    /// `emitGatheredSource(items)`.
    pub fn emit_gathered_source(&mut self, items: Vec<Source>) {
        for item in items {
            self.ctx().emit_item(item);
        }
    }

    /// The last step of `emitAnnotated`: emits the gathered `items` as one
    /// annotated item.
    pub fn emit_annotated_items(&mut self, annotation: AnnotationData, items: Vec<Source>) {
        let source = Source::Sequence(items);
        self.ctx().emit_item(annotated(annotation, source));
    }

    /// `emitTable(tableArray)`: one table item and a newline; nothing for
    /// an empty table.
    pub fn emit_table(&mut self, table_array: Vec<Vec<Source>>) {
        if table_array.is_empty() {
            return;
        }
        self.ctx().emit_item(Source::Table(table_array));
        self.ctx().emit_newline();
    }

    /// `changeIndent(offset)`: changes the indentation from the next line
    /// on. Errors if no line has been emitted yet.
    pub fn change_indent(&mut self, offset: i32) -> Result<()> {
        self.ctx().change_indent(offset)
    }

    /// `initializeEmitContextForFilename(filename)`: continues a finished
    /// file (found case-insensitively) instead of the current context.
    pub fn initialize_emit_context_for_filename(&mut self, filename: &str) {
        if let Some(&existing) = self.finished_emit_contexts.get(&filename.to_lowercase()) {
            self.current = existing;
        }
    }

    /// `Renderer.finishFile(filename)`: stores the current context as the
    /// file `filename` and starts a new one. Finishing a file name twice
    /// prints a warning to stdout (with `console.log`, as TypeScript does)
    /// and replaces the contents, keeping the file's position.
    pub fn finish_file(&mut self, filename: &str) {
        if self.finished_files.contains_key(filename) {
            console_log(&format!(
                "[WARNING] Tried to emit file {filename} more than once. If performing multi-file output this warning can be safely ignored."
            ));
        }
        let len = self.contexts[self.current].items.len();
        self.finished_files
            .insert(filename.to_owned(), (self.current, len));
        self.finished_emit_contexts
            .insert(filename.to_lowercase(), self.current);
        self.contexts[self.current].finished = true;
        self.contexts.push(EmitContext::new());
        self.current = self.contexts.len() - 1;
    }

    /// The finished files and the names, after rendering.
    pub(crate) fn take_render_result(&mut self) -> Result<RenderResult> {
        let names = match self.names.take() {
            Some(names) => names,
            None => return panic("Names accessed before they were assigned"),
        };
        let sources = self
            .finished_files
            .iter()
            .map(|(name, &(context, len))| {
                let items = self.contexts[context].items[..len].to_vec();
                (name.clone(), Source::Sequence(items))
            })
            .collect();
        Ok(RenderResult { sources, names })
    }
}

/// `RendererUnknownOptionValue`: an enum option got a value it doesn't
/// declare. Raised when the renderer parses its options.
impl From<crate::renderer_options::UnknownOptionValue> for QuickTypeError {
    fn from(e: crate::renderer_options::UnknownOptionValue) -> Self {
        QuickTypeError::new(
            ErrorKind::RendererUnknownOptionValue,
            vec![("value", e.value.into()), ("name", e.name.into())],
        )
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn line_indentation_counts_spaces_and_tabs() {
        assert_eq!(line_indentation("    x"), (4, Some("x")));
        assert_eq!(line_indentation("\tx y"), (4, Some("x y")));
        assert_eq!(line_indentation("  \tx"), (6, Some("x")));
        assert_eq!(line_indentation("   "), (0, None));
        assert_eq!(line_indentation(""), (0, None));
    }

    fn core_with_graph<R>(f: impl FnOnce(&mut RendererCore<'_>) -> R) -> R {
        let mut builder = crate::ty::type_builder::TypeBuilder::new(
            crate::ty::type_builder_utils::get_no_string_type_mapping(),
            false,
            false,
            false,
            false,
        )
        .unwrap();
        let t = builder
            .get_primitive_type(
                crate::ty::transformed_string_type::TypeKind::Bool,
                crate::attributes::type_attributes::TypeAttributes::new(),
                None,
            )
            .unwrap();
        builder.add_top_level("TopLevel", t).unwrap();
        let graph = builder.finish().unwrap();
        let language = crate::language::rust::language::RustTargetLanguage;
        let mut core = RendererCore::new(
            &language,
            RenderContext {
                type_graph: &graph,
                leading_comments: None,
            },
        );
        f(&mut core)
    }

    fn lines_of(core: &RendererCore<'_>) -> Vec<String> {
        let source = Source::Sequence(core.emit_context().source().to_vec());
        crate::source::serialize_render_result(&source, &Names::new(), "  ")
            .unwrap()
            .lines
    }

    #[test]
    fn emit_line_once_compares_like_javascript() {
        core_with_graph(|core| {
            // TS `emitLine(["import \"fmt\""])`: an array item, never `===`.
            core.emit_line(crate::sl!["import \"fmt\""]);
            core.emit_line_once(vec!["import \"fmt\"".into()]);
            // TS `emitLine("x")`: a string item, deduplicated by value.
            core.emit_line("x");
            core.emit_line_once(vec!["x".into()]);
            // Several parts are always an array.
            core.emit_line_once(vec!["y".into(), "z".into()]);
            core.emit_line_once(vec!["y".into(), "z".into()]);
            // An array item never matches either.
            core.emit_item(crate::sl!["w"]);
            core.emit_line_parts(vec![]);
            core.emit_line_once(vec![crate::sl!["w"]]);
            assert_eq!(
                lines_of(core),
                [
                    "import \"fmt\"",
                    "import \"fmt\"",
                    "x",
                    "yz",
                    "yz",
                    "w",
                    "w",
                    ""
                ]
            );
            assert!(core.emit_item_once(crate::sl![]));
            assert!(core.emit_item_once(crate::sl![]));
            assert!(core.emit_item_once("w"));
            assert!(!core.emit_item_once("w"));
        });
    }

    #[test]
    fn gather_contexts_are_freed_and_finished_ones_kept() {
        core_with_graph(|core| {
            core.emit_line("a");
            core.finish_file("f");
            let saved = core.begin_gather();
            core.emit_line("gathered");
            let items = core.end_gather(saved);
            assert_eq!(items.len(), 2);
            assert_eq!(core.contexts.len(), 2);
            // A gather that reopens a finished file returns a copy of it.
            let saved = core.begin_gather();
            core.initialize_emit_context_for_filename("F");
            core.emit_line("b");
            let items = core.end_gather(saved);
            assert_eq!(items.len(), 4);
            assert_eq!(core.finished_files["f"], (0, 2));
            assert_eq!(core.contexts[0].items.len(), 4);
        });
    }

    #[test]
    fn positions() {
        assert_eq!(ForEachPosition::of(0, 1), ForEachPosition::Only);
        assert_eq!(ForEachPosition::of(0, 3), ForEachPosition::First);
        assert_eq!(ForEachPosition::of(1, 3), ForEachPosition::Middle);
        assert_eq!(ForEachPosition::of(2, 3), ForEachPosition::Last);
        let cfg: BlankLineConfig = (BlankLinePosition::LeadingAndInterposing, 2).into();
        assert_eq!(cfg.counts(), (2, 2));
        assert_eq!(
            BlankLineConfig::from(BlankLinePosition::Leading).counts(),
            (0, 1)
        );
    }
}

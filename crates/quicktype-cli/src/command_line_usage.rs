//! Port of `command-line-usage` 7.0.1 (`node_modules/command-line-usage/dist/index.cjs`)
//! and the libraries it bundles: `table-layout` 3.0.2 and `wordwrapjs` 5.1.0.
//! Strings go through [`chalk_format`] like in the original.
//!
//! The port covers content sections (a string or lines of text) and option
//! lists, with the column sizing and word wrapping quirks that decide the
//! exact layout. All widths count UTF-16 code units with ANSI escape codes
//! removed, as in JS.

use quicktype_core::renderer_options::{OptionDefinition, OptionType};

use crate::chalk::{Chalk, chalk_format};
use crate::js;

/// `os.EOL`, which joins the lines inside a section.
const EOL: &str = if cfg!(windows) { "\r\n" } else { "\n" };

/// Text padding of a table column.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Padding {
    /// Text before the cell.
    pub left: String,
    /// Text after the cell.
    pub right: String,
}

impl Padding {
    /// A padding of the given left and right text.
    pub fn new(left: &str, right: &str) -> Self {
        Self {
            left: left.to_owned(),
            right: right.to_owned(),
        }
    }

    fn len(&self) -> i64 {
        to_i64(js::len(&self.left) + js::len(&self.right))
    }
}

/// Per-column table options.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct ColumnOptions {
    /// The column (the row key) these options apply to.
    pub name: String,
    /// Fixed width, including padding.
    pub width: Option<usize>,
    /// Maximum width, including padding.
    pub max_width: Option<usize>,
    /// Never wrap this column.
    pub no_wrap: bool,
    /// Column-specific padding.
    pub padding: Option<Padding>,
}

/// `tableOptions` of a section.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct TableOptions {
    /// Padding of every column (default `" "`/`" "`).
    pub padding: Padding,
    /// Width the layout tries to fit in (default 80).
    pub max_width: i64,
    /// Column-specific options.
    pub columns: Vec<ColumnOptions>,
}

impl Default for TableOptions {
    fn default() -> Self {
        Self {
            padding: Padding::new(" ", " "),
            max_width: 80,
            columns: vec![],
        }
    }
}

/// The content of a content section.
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum Content {
    /// One string, wrapped as a paragraph.
    Text(String),
    /// One string per line.
    Lines(Vec<String>),
}

/// One section of the usage guide.
#[derive(Clone, Debug, PartialEq)]
pub enum Section {
    /// A header and/or content.
    Content {
        /// Bold section title.
        header: Option<String>,
        /// The text.
        content: Option<Content>,
    },
    /// A table of options.
    OptionList {
        /// Bold section title.
        header: Option<String>,
        /// The options to list.
        options: Vec<OptionDefinition>,
        /// Names of options not to list.
        hide: Vec<String>,
        /// Table layout (command-line-usage has a default).
        table_options: Option<TableOptions>,
    },
}

fn to_i64(n: usize) -> i64 {
    i64::try_from(n).unwrap_or(i64::MAX)
}

// ---------------------------------------------------------------------------
// ansi helpers

/// Removes `/\u001b.*?m/g` matches.
fn remove_ansi(input: &str) -> String {
    let mut out = String::with_capacity(input.len());
    let mut rest = input;
    while let Some(esc) = rest.find('\u{1b}') {
        out.push_str(&rest[..esc]);
        let after = &rest[esc + 1..];
        let end = after.find(|c: char| c == 'm' || js::is_line_terminator(c));
        match end {
            Some(m) if after[m..].starts_with('m') => rest = &after[m + 1..],
            _ => {
                out.push('\u{1b}');
                rest = after;
            }
        }
    }
    out.push_str(rest);
    out
}

/// UTF-16 length without ANSI escape codes.
fn visible_len(s: &str) -> i64 {
    to_i64(js::len(&remove_ansi(s)))
}

// ---------------------------------------------------------------------------
// wordwrapjs

/// `text.match(/[^\s-]+?-\b|\S+|\s+|\r\n?|\n/g)`.
fn chunks(text: &str) -> Vec<&str> {
    let mut out = vec![];
    let mut i = 0;
    while i < text.len() {
        let rest = &text[i..];
        let first = rest.chars().next().unwrap_or(' ');
        let len = if js::is_whitespace(first) {
            rest.find(|c: char| !js::is_whitespace(c))
                .unwrap_or(rest.len())
        } else {
            // `[^\s-]+?-\b`: a run without hyphens, the hyphen ending it, and a
            // word character right after the hyphen.
            let run = rest
                .find(|c: char| js::is_whitespace(c) || c == '-')
                .unwrap_or(rest.len());
            let hyphenated = run > 0
                && rest[run..].starts_with('-')
                && rest[run + 1..].chars().next().is_some_and(js::is_word_char);
            if hyphenated {
                run + 1
            } else {
                rest.find(js::is_whitespace).unwrap_or(rest.len())
            }
        };
        out.push(&rest[..len]);
        i += len;
    }
    out
}

/// `Wordwrap.isWrappable(text)`.
fn is_wrappable(text: &str) -> bool {
    chunks(text).len() > 1
}

/// `Wordwrap.lines(text, { width })` (no `break`, no `noTrim`).
fn wrap_lines(text: &str, width: i64) -> Vec<String> {
    const EMPTY: &str = "~~empty~~";
    let mut wrapped: Vec<String> = vec![];
    let mut rest = text;
    loop {
        // `split(/\r\n|\n/)`
        let (line, next) = match rest.find('\n') {
            Some(i) => {
                let line = &rest[..i];
                (
                    line.strip_suffix('\r').unwrap_or(line),
                    Some(&rest[i + 1..]),
                )
            }
            None => (rest, None),
        };
        let line = js::trim(line);
        let words = if line.is_empty() {
            vec![EMPTY]
        } else {
            chunks(line)
        };
        let mut lines = vec![String::new()];
        for word in words {
            let current = lines.last_mut().expect("lines starts non-empty");
            if visible_len(word) + visible_len(current) > width {
                lines.push(word.to_owned());
            } else {
                current.push_str(word);
            }
        }
        wrapped.extend(lines);
        match next {
            Some(next) => rest = next,
            None => break,
        }
    }
    wrapped
        .iter()
        .map(|line| js::trim(line))
        .filter(|line| !js::trim(line).is_empty())
        .map(|line| line.replacen(EMPTY, "", 1))
        .collect()
}

/// `text.split(/\r\n?|\n/)`.
fn split_lines(text: &str) -> Vec<String> {
    let mut lines = vec![];
    let mut current = String::new();
    let mut chars = text.chars().peekable();
    while let Some(c) = chars.next() {
        match c {
            '\r' => {
                if chars.peek() == Some(&'\n') {
                    chars.next();
                }
                lines.push(std::mem::take(&mut current));
            }
            '\n' => lines.push(std::mem::take(&mut current)),
            c => current.push(c),
        }
    }
    lines.push(current);
    lines
}

// ---------------------------------------------------------------------------
// table-layout

struct Column {
    name: String,
    width: Option<i64>,
    max_width: Option<i64>,
    min_width: Option<i64>,
    no_wrap: bool,
    content_wrappable: bool,
    content_width: i64,
    min_content_width: i64,
    padding: Padding,
    generated_width: i64,
}

impl Column {
    fn is_fixed(&self) -> bool {
        self.width.is_some() || self.no_wrap || !self.content_wrappable
    }

    fn generate_width(&mut self) {
        self.generated_width = match self.width {
            Some(w) if w != 0 => w,
            _ => self.content_width + self.padding.len(),
        };
    }

    fn wrapped_content_width(&self) -> i64 {
        (self.generated_width - self.padding.len()).max(0)
    }
}

/// `Columns.autoSize`.
fn auto_size(columns: &mut [Column], max_width: i64) {
    for column in columns.iter_mut() {
        column.generate_width();
        column.min_width = Some(column.min_content_width + column.padding.len());
    }
    for column in columns.iter_mut() {
        if let Some(max) = column.max_width {
            if column.generated_width > max {
                column.generated_width = max;
            }
        }
        if let Some(min) = column.min_width {
            if column.generated_width < min {
                column.generated_width = min;
            }
        }
    }
    let total: i64 = columns.iter().map(|c| c.generated_width).sum();
    let total_fixed: i64 = columns
        .iter()
        .filter(|c| c.is_fixed())
        .map(|c| c.generated_width)
        .sum();
    let total_resizable = (max_width - total_fixed).max(0);
    if total - max_width > 0 {
        let resizable: Vec<usize> = (0..columns.len())
            .filter(|&i| !columns[i].is_fixed())
            .collect();
        for &i in &resizable {
            columns[i].generated_width = total_resizable.div_euclid(to_i64(resizable.len()));
        }
        let grown: Vec<usize> = (0..columns.len())
            .filter(|&i| columns[i].generated_width > columns[i].content_width)
            .collect();
        let shrunken: Vec<usize> = (0..columns.len())
            .filter(|&i| columns[i].generated_width < columns[i].content_width)
            .collect();
        let mut salvaged = 0;
        for &i in &grown {
            let current = columns[i].generated_width;
            columns[i].generate_width();
            salvaged += current - columns[i].generated_width;
        }
        for &i in &shrunken {
            columns[i].generated_width += salvaged.div_euclid(to_i64(shrunken.len()));
        }
    }
}

/// `new Table(rows, options).renderLines()`; each row maps column names to
/// cell text, and the first row's key order fixes the column order.
fn render_table(rows: &[Vec<(&str, String)>], options: &TableOptions) -> Vec<String> {
    let mut columns: Vec<Column> = vec![];
    for row in rows {
        for (name, _) in row {
            if !columns.iter().any(|c| c.name == *name) {
                columns.push(Column {
                    name: (*name).to_owned(),
                    width: None,
                    max_width: None,
                    min_width: None,
                    no_wrap: false,
                    content_wrappable: false,
                    content_width: 0,
                    min_content_width: 0,
                    padding: options.padding.clone(),
                    generated_width: 0,
                });
            }
        }
    }
    for column_options in &options.columns {
        if let Some(column) = columns.iter_mut().find(|c| c.name == column_options.name) {
            if let Some(padding) = &column_options.padding {
                column.padding = padding.clone();
            }
            column.width = column_options.width.map(to_i64);
            column.max_width = column_options.max_width.map(to_i64);
            column.min_width = None;
            column.no_wrap = column_options.no_wrap;
        }
    }
    for row in rows {
        for (name, value) in row {
            let Some(column) = columns.iter_mut().find(|c| c.name == *name) else {
                continue;
            };
            let value = remove_ansi(value);
            column.content_width = column.content_width.max(to_i64(js::len(&value)));
            let longest_word = chunks(&value)
                .iter()
                .map(|w| to_i64(js::len(w)))
                .max()
                .unwrap_or(0);
            column.min_content_width = column.min_content_width.max(longest_word);
            if !column.content_wrappable {
                column.content_wrappable = is_wrappable(&value);
            }
        }
    }
    auto_size(&mut columns, options.max_width);
    // `getWrapped` sizes the columns again; the result is the same.
    auto_size(&mut columns, options.max_width);

    let mut lines = vec![];
    for row in rows {
        let wrapped: Vec<Vec<String>> = columns
            .iter()
            .map(|column| {
                let value = row
                    .iter()
                    .find(|(name, _)| *name == column.name)
                    .map_or("", |(_, v)| v.as_str());
                if column.no_wrap {
                    split_lines(value)
                } else {
                    wrap_lines(value, column.wrapped_content_width())
                }
            })
            .collect();
        let most = wrapped.iter().map(Vec::len).max().unwrap_or(0);
        for i in 0..most {
            let mut line = String::new();
            for (column, cell) in columns.iter().zip(&wrapped) {
                let cell = cell.get(i).map_or("", String::as_str);
                let ansi_len = to_i64(js::len(cell)) - visible_len(cell);
                let width = column.generated_width - column.padding.len() + ansi_len;
                line.push_str(&column.padding.left);
                line.push_str(&js::pad_end(cell, usize::try_from(width).unwrap_or(0)));
                line.push_str(&column.padding.right);
            }
            lines.push(line);
        }
    }
    lines
}

// ---------------------------------------------------------------------------
// sections

/// `getOptionNames(definition)`; the type comes from `optionType` like in
/// quicktype's `optionDefinitionsForUsage`.
fn option_names(chalk: &Chalk, definition: &OptionDefinition) -> String {
    let type_name = if definition.option_type == OptionType::Boolean {
        String::new()
    } else {
        let multiple = if definition.multiple { "[]" } else { "" };
        format!("{{underline string{multiple}}}")
    };
    let label = match definition.type_label.as_deref() {
        Some(label) if !label.is_empty() => label.to_owned(),
        _ => type_name,
    };
    let label = chalk_format(chalk, &label);
    let template = match definition.alias {
        Some(alias) => format!("{{bold -{alias}}}, {{bold --{}}} {label}", definition.name),
        None => format!("{{bold --{}}} {label}", definition.name),
    };
    chalk_format(chalk, &template)
}

fn header_lines(chalk: &Chalk, header: Option<&str>, lines: &mut Vec<String>) {
    if let Some(header) = header.filter(|h| !h.is_empty()) {
        lines.push(chalk_format(chalk, &format!("{{bold {header}}}")));
        lines.push(String::new());
    }
}

fn section_lines(chalk: &Chalk, section: &Section) -> Vec<String> {
    let mut lines = vec![];
    match section {
        Section::Content { header, content } => {
            header_lines(chalk, header.as_deref(), &mut lines);
            let texts: Option<Vec<&str>> = match content {
                Some(Content::Text(text)) if !text.is_empty() => Some(vec![text.as_str()]),
                Some(Content::Lines(texts)) => Some(texts.iter().map(String::as_str).collect()),
                _ => None,
            };
            if let Some(texts) = texts {
                let rows: Vec<Vec<(&str, String)>> = texts
                    .iter()
                    .map(|text| vec![("column", chalk_format(chalk, text))])
                    .collect();
                let options = TableOptions {
                    padding: Padding::new("  ", " "),
                    ..TableOptions::default()
                };
                lines.extend(render_table(&rows, &options));
                lines.push(String::new());
            }
        }
        Section::OptionList {
            header,
            options,
            hide,
            table_options,
        } => {
            header_lines(chalk, header.as_deref(), &mut lines);
            let rows: Vec<Vec<(&str, String)>> = options
                .iter()
                .filter(|d| !hide.iter().any(|h| *h == d.name))
                .map(|d| {
                    vec![
                        ("option", option_names(chalk, d)),
                        ("description", chalk_format(chalk, &d.description)),
                    ]
                })
                .collect();
            let default_options;
            let table_options = match table_options {
                Some(options) => options,
                None => {
                    default_options = TableOptions {
                        padding: Padding::new("  ", " "),
                        columns: vec![
                            ColumnOptions {
                                name: "option".to_owned(),
                                no_wrap: true,
                                ..ColumnOptions::default()
                            },
                            ColumnOptions {
                                name: "description".to_owned(),
                                max_width: Some(80),
                                ..ColumnOptions::default()
                            },
                        ],
                        ..TableOptions::default()
                    };
                    &default_options
                }
            };
            lines.extend(render_table(&rows, table_options));
            lines.push(String::new());
        }
    }
    lines
}

/// `commandLineUsage(sections)`: the usage guide, starting with a newline.
pub fn command_line_usage(chalk: &Chalk, sections: &[Section]) -> String {
    if sections.is_empty() {
        return String::new();
    }
    let sections: Vec<String> = sections
        .iter()
        .map(|s| section_lines(chalk, s).join(EOL))
        .collect();
    format!("\n{}", sections.join("\n"))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn chunking() {
        assert_eq!(chunks("prop-types|x"), ["prop-", "types|x"]);
        assert_eq!(chunks("a-|b c"), ["a-|b", " ", "c"]);
        assert_eq!(chunks("--out FILE"), ["--out", " ", "FILE"]);
        assert_eq!(chunks("upper-"), ["upper-"]);
        assert_eq!(chunks("x-y-z"), ["x-", "y-", "z"]);
    }

    #[test]
    fn wrapping() {
        assert_eq!(wrap_lines("", 10), [""]);
        assert_eq!(wrap_lines("aaa bbb ccc", 7), ["aaa bbb", "ccc"]);
        assert_eq!(wrap_lines("  a\n\n  b", 10), ["a", "", "b"]);
        assert_eq!(
            wrap_lines("averyveryverylongword x", 5),
            ["averyveryverylongword", "x"]
        );
    }

    #[test]
    fn ansi() {
        assert_eq!(remove_ansi("\u{1b}[1mx\u{1b}[22m"), "x");
        assert_eq!(remove_ansi("\u{1b}x\nm"), "\u{1b}x\nm");
    }

    #[test]
    fn content_section() {
        let chalk = Chalk::new(0);
        let usage = command_line_usage(
            &chalk,
            &[Section::Content {
                header: Some("Title".into()),
                content: Some(Content::Text("Hello".into())),
            }],
        );
        assert_eq!(usage, "\nTitle\n\n  Hello \n");
    }
}

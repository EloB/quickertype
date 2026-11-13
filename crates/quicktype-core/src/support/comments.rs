//! Port of `packages/quicktype-core/src/support/Comments.ts`.
//!
//! Comments a caller can put at the top of the generated code (the
//! `leadingComments` option), as interpreted by
//! [`emit_comments`](crate::convenience_renderer::ConvenienceRendererExt::emit_comments).

use crate::source::Source;

/// `CommentOptions`: how to delimit comment lines.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct CommentOptions {
    /// A line after the comment, e.g. `" */"`.
    pub after_comment: Option<String>,
    /// A line before the comment, e.g. `"/**"`.
    pub before_comment: Option<String>,
    /// The start of the first line; defaults to `line_start`.
    pub first_line_start: Option<String>,
    /// Appended to every line.
    pub line_end: Option<String>,
    /// The start of every line; defaults to the renderer's
    /// `comment_line_start`.
    pub line_start: Option<String>,
}

/// `Comment`: a string, or one of the `CommentConfig` shapes.
#[derive(Clone, Debug)]
pub enum Comment {
    /// A plain string: one comment line.
    String(String),
    /// `{ lines }`: comment lines in the renderer's default style.
    Lines(Vec<Source>),
    /// `{ descriptionBlock }`: lines emitted as a description block.
    DescriptionBlock(Vec<Source>),
    /// `CommentOptions & { customLines }`: lines with custom delimiters.
    Custom {
        /// The delimiters.
        options: CommentOptions,
        /// The lines.
        custom_lines: Vec<Source>,
    },
}

impl Comment {
    /// `isStringComment(comment)`.
    pub fn is_string_comment(&self) -> bool {
        matches!(self, Comment::String(_))
    }
}

impl From<&str> for Comment {
    fn from(s: &str) -> Self {
        Comment::String(s.to_owned())
    }
}

impl From<String> for Comment {
    fn from(s: String) -> Self {
        Comment::String(s)
    }
}

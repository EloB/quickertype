//! Port of graphql-js 16.14.2 `language/lexer.js`, with the parts of
//! `language/tokenKind.js`, `language/characterClasses.js` and
//! `language/blockString.js` (`dedentBlockStringLines`) it uses.
//!
//! The source is lexed as JavaScript sees it, in UTF-16 code units, so
//! positions, surrogate handling and the code points quoted in error
//! messages are graphql-js's. Tokens are produced lazily, one
//! [`advance`](Lexer::advance) at a time, so a lexical error surfaces at
//! the same point of parsing as in graphql-js. Line and column tracking is
//! left out: quicktype only ever shows an error's message, which has no
//! location.

use super::error::{GraphQlError, syntax_error};

/// `TokenKind`: the kinds of tokens, with graphql-js's string values.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum TokenKind {
    /// `<SOF>`, the start of the document.
    Sof,
    /// `<EOF>`, the end of the document.
    Eof,
    /// `!`
    Bang,
    /// `$`
    Dollar,
    /// `&`
    Amp,
    /// `(`
    ParenL,
    /// `)`
    ParenR,
    /// `.` (only schema coordinates have it; the document lexer never
    /// produces it)
    Dot,
    /// `...`
    Spread,
    /// `:`
    Colon,
    /// `=`
    Equals,
    /// `@`
    At,
    /// `[`
    BracketL,
    /// `]`
    BracketR,
    /// `{`
    BraceL,
    /// `|`
    Pipe,
    /// `}`
    BraceR,
    /// `Name`
    Name,
    /// `Int`
    Int,
    /// `Float`
    Float,
    /// `String`
    String,
    /// `BlockString`
    BlockString,
    /// `Comment`
    Comment,
}

impl TokenKind {
    /// The kind's value in graphql-js's `TokenKind` enum.
    pub fn as_str(self) -> &'static str {
        match self {
            TokenKind::Sof => "<SOF>",
            TokenKind::Eof => "<EOF>",
            TokenKind::Bang => "!",
            TokenKind::Dollar => "$",
            TokenKind::Amp => "&",
            TokenKind::ParenL => "(",
            TokenKind::ParenR => ")",
            TokenKind::Dot => ".",
            TokenKind::Spread => "...",
            TokenKind::Colon => ":",
            TokenKind::Equals => "=",
            TokenKind::At => "@",
            TokenKind::BracketL => "[",
            TokenKind::BracketR => "]",
            TokenKind::BraceL => "{",
            TokenKind::Pipe => "|",
            TokenKind::BraceR => "}",
            TokenKind::Name => "Name",
            TokenKind::Int => "Int",
            TokenKind::Float => "Float",
            TokenKind::String => "String",
            TokenKind::BlockString => "BlockString",
            TokenKind::Comment => "Comment",
        }
    }

    /// `isPunctuatorTokenKind(kind)`.
    pub fn is_punctuator(self) -> bool {
        matches!(
            self,
            TokenKind::Bang
                | TokenKind::Dollar
                | TokenKind::Amp
                | TokenKind::ParenL
                | TokenKind::ParenR
                | TokenKind::Dot
                | TokenKind::Spread
                | TokenKind::Colon
                | TokenKind::Equals
                | TokenKind::At
                | TokenKind::BracketL
                | TokenKind::BracketR
                | TokenKind::BraceL
                | TokenKind::Pipe
                | TokenKind::BraceR
        )
    }
}

/// A token (`Token` in `ast.js`), as much of it as the parser uses.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Token {
    /// The kind.
    pub kind: TokenKind,
    /// The offset of its first code unit.
    pub start: usize,
    /// The offset after its last code unit.
    pub end: usize,
    /// The value of names, numbers, strings and comments (`undefined` for
    /// punctuators, `<SOF>` and `<EOF>`). Strings have their escapes
    /// decoded; block strings are dedented.
    pub value: Option<String>,
}

/// `getTokenKindDesc(kind)`: punctuators quoted.
pub fn token_kind_desc(kind: TokenKind) -> String {
    if kind.is_punctuator() {
        format!("\"{}\"", kind.as_str())
    } else {
        kind.as_str().to_owned()
    }
}

/// `getTokenDesc(token)`: the kind, and the value in quotes if it has one.
pub fn token_desc(token: &Token) -> String {
    let mut desc = token_kind_desc(token.kind);
    if let Some(value) = &token.value {
        desc.push_str(" \"");
        desc.push_str(value);
        desc.push('"');
    }
    desc
}

/// The code unit at `index`, or `None` past the end (JavaScript's `NaN`
/// from `charCodeAt`, which equals nothing).
fn code_at(body: &[u16], index: usize) -> Option<u16> {
    body.get(index).copied()
}

/// `isDigit(code)`.
fn is_digit(code: Option<u16>) -> bool {
    matches!(code, Some(0x30..=0x39))
}

/// `isLetter(code)`.
fn is_letter(code: Option<u16>) -> bool {
    matches!(code, Some(0x61..=0x7a | 0x41..=0x5a))
}

/// `isNameStart(code)`.
fn is_name_start(code: Option<u16>) -> bool {
    is_letter(code) || code == Some(0x5f)
}

/// `isNameContinue(code)`.
fn is_name_continue(code: Option<u16>) -> bool {
    is_letter(code) || is_digit(code) || code == Some(0x5f)
}

/// `isWhiteSpace(code)`: tab and space.
fn is_white_space(code: u16) -> bool {
    code == 0x09 || code == 0x20
}

/// `isUnicodeScalarValue(code)`.
fn is_unicode_scalar_value(code: i64) -> bool {
    (0..=0xd7ff).contains(&code) || (0xe000..=0x10ffff).contains(&code)
}

/// `isLeadingSurrogate(code)`.
fn is_leading_surrogate(code: i64) -> bool {
    (0xd800..=0xdbff).contains(&code)
}

/// `isTrailingSurrogate(code)`.
fn is_trailing_surrogate(code: i64) -> bool {
    (0xdc00..=0xdfff).contains(&code)
}

/// `charCodeAt` as a number, with `NaN` as a value no predicate accepts.
fn code_number(code: Option<u16>) -> i64 {
    code.map_or(-1, i64::from)
}

/// `isSupplementaryCodePoint(body, location)`: a surrogate pair starts at
/// `location`.
fn is_supplementary_code_point(body: &[u16], location: usize) -> bool {
    is_leading_surrogate(code_number(code_at(body, location)))
        && is_trailing_surrogate(code_number(code_at(body, location + 1)))
}

/// `body.slice(start, end)` as a string (a cut surrogate pair becomes
/// U+FFFD, as Node prints it).
fn slice(body: &[u16], start: usize, end: usize) -> String {
    let end = end.min(body.len());
    let start = start.min(end);
    String::from_utf16_lossy(&body[start..end])
}

/// `String.fromCodePoint(point)` of a Unicode scalar value.
fn from_code_point(point: u32) -> char {
    char::from_u32(point).unwrap_or(char::REPLACEMENT_CHARACTER)
}

/// The lexer (`Lexer`): a stream of tokens over a source.
#[derive(Debug)]
pub struct Lexer {
    body: Vec<u16>,
    /// The current non-ignored token (`token`).
    token: Token,
    /// The token after `token`, once [`lookahead`](Self::lookahead) has
    /// read it (graphql-js's `token.next` link).
    next: Option<Token>,
}

impl Lexer {
    /// `new Lexer(new Source(body))`: positioned at the `<SOF>` token.
    pub fn new(body: &str) -> Self {
        Lexer {
            body: body.encode_utf16().collect(),
            token: Token {
                kind: TokenKind::Sof,
                start: 0,
                end: 0,
                value: None,
            },
            next: None,
        }
    }

    /// `lexer.token`: the current token.
    pub fn token(&self) -> &Token {
        &self.token
    }

    /// `advance()`: moves to the next non-ignored token.
    pub fn advance(&mut self) -> Result<&Token, GraphQlError> {
        let next = self.lookahead()?.clone();
        self.next = None;
        self.token = next;
        Ok(&self.token)
    }

    /// `lookahead()`: the next non-ignored token, without advancing. At
    /// `<EOF>` that is `<EOF>` itself.
    pub fn lookahead(&mut self) -> Result<&Token, GraphQlError> {
        if self.token.kind == TokenKind::Eof {
            return Ok(&self.token);
        }
        if self.next.is_none() {
            let mut end = self.token.end;
            let token = loop {
                let token = self.read_next_token(end)?;
                if token.kind != TokenKind::Comment {
                    break token;
                }
                end = token.end;
            };
            self.next = Some(token);
        }
        match &self.next {
            Some(token) => Ok(token),
            None => Ok(&self.token),
        }
    }

    /// `printCodePointAt(lexer, location)`: printable ASCII in quotes, any
    /// other code point as `U+XXXX`, `<EOF>` past the end.
    fn print_code_point_at(&self, location: usize) -> String {
        let Some(code) = quicktype_js_compat::utf16::code_point_at_units(&self.body, location)
        else {
            return TokenKind::Eof.as_str().to_owned();
        };
        if (0x20..=0x7e).contains(&code) {
            let c = from_code_point(code);
            return if c == '"' {
                "'\"'".to_owned()
            } else {
                format!("\"{c}\"")
            };
        }
        format!("U+{code:04X}")
    }

    fn error(&self, position: usize, description: impl Into<String>) -> GraphQlError {
        syntax_error(position, description)
    }

    fn make_token(kind: TokenKind, start: usize, end: usize, value: Option<String>) -> Token {
        Token {
            kind,
            start,
            end,
            value,
        }
    }

    /// `readNextToken(lexer, start)`.
    fn read_next_token(&self, start: usize) -> Result<Token, GraphQlError> {
        let body = &self.body;
        let body_length = body.len();
        let mut position = start;
        while position < body_length {
            let code = body[position];
            let punctuator = |kind| Ok(Self::make_token(kind, position, position + 1, None));
            match code {
                // BOM, tab, space, comma; LF; CR (with an optional LF).
                0xfeff | 0x09 | 0x20 | 0x2c | 0x0a => {
                    position += 1;
                    continue;
                }
                0x0d => {
                    position += if code_at(body, position + 1) == Some(0x0a) {
                        2
                    } else {
                        1
                    };
                    continue;
                }
                0x23 => return Ok(self.read_comment(position)),
                0x21 => return punctuator(TokenKind::Bang),
                0x24 => return punctuator(TokenKind::Dollar),
                0x26 => return punctuator(TokenKind::Amp),
                0x28 => return punctuator(TokenKind::ParenL),
                0x29 => return punctuator(TokenKind::ParenR),
                0x2e => {
                    if code_at(body, position + 1) == Some(0x2e)
                        && code_at(body, position + 2) == Some(0x2e)
                    {
                        return Ok(Self::make_token(
                            TokenKind::Spread,
                            position,
                            position + 3,
                            None,
                        ));
                    }
                }
                0x3a => return punctuator(TokenKind::Colon),
                0x3d => return punctuator(TokenKind::Equals),
                0x40 => return punctuator(TokenKind::At),
                0x5b => return punctuator(TokenKind::BracketL),
                0x5d => return punctuator(TokenKind::BracketR),
                0x7b => return punctuator(TokenKind::BraceL),
                0x7c => return punctuator(TokenKind::Pipe),
                0x7d => return punctuator(TokenKind::BraceR),
                0x22 => {
                    if code_at(body, position + 1) == Some(0x22)
                        && code_at(body, position + 2) == Some(0x22)
                    {
                        return self.read_block_string(position);
                    }
                    return self.read_string(position);
                }
                _ => {}
            }
            if is_digit(Some(code)) || code == 0x2d {
                return self.read_number(position, Some(code));
            }
            if is_name_start(Some(code)) {
                return Ok(self.read_name(position));
            }
            let description = if code == 0x27 {
                "Unexpected single quote character ('), did you mean to use a double quote (\")?"
                    .to_owned()
            } else if is_unicode_scalar_value(i64::from(code))
                || is_supplementary_code_point(body, position)
            {
                format!(
                    "Unexpected character: {}.",
                    self.print_code_point_at(position)
                )
            } else {
                format!("Invalid character: {}.", self.print_code_point_at(position))
            };
            return Err(self.error(position, description));
        }
        Ok(Self::make_token(
            TokenKind::Eof,
            body_length,
            body_length,
            None,
        ))
    }

    /// `readComment(lexer, start)`. Comments are skipped, so their value is
    /// left out.
    fn read_comment(&self, start: usize) -> Token {
        let body = &self.body;
        let mut position = start + 1;
        while position < body.len() {
            let code = body[position];
            if code == 0x0a || code == 0x0d {
                break;
            }
            if is_unicode_scalar_value(i64::from(code)) {
                position += 1;
            } else if is_supplementary_code_point(body, position) {
                position += 2;
            } else {
                break;
            }
        }
        Self::make_token(TokenKind::Comment, start, position, None)
    }

    /// `readNumber(lexer, start, firstCode)`.
    fn read_number(&self, start: usize, first_code: Option<u16>) -> Result<Token, GraphQlError> {
        let body = &self.body;
        let mut position = start;
        let mut code = first_code;
        let mut is_float = false;
        if code == Some(0x2d) {
            position += 1;
            code = code_at(body, position);
        }
        if code == Some(0x30) {
            position += 1;
            code = code_at(body, position);
            if is_digit(code) {
                return Err(self.error(
                    position,
                    format!(
                        "Invalid number, unexpected digit after 0: {}.",
                        self.print_code_point_at(position)
                    ),
                ));
            }
        } else {
            position = self.read_digits(position, code)?;
            code = code_at(body, position);
        }
        if code == Some(0x2e) {
            is_float = true;
            position += 1;
            code = code_at(body, position);
            position = self.read_digits(position, code)?;
            code = code_at(body, position);
        }
        if code == Some(0x45) || code == Some(0x65) {
            is_float = true;
            position += 1;
            code = code_at(body, position);
            if code == Some(0x2b) || code == Some(0x2d) {
                position += 1;
                code = code_at(body, position);
            }
            position = self.read_digits(position, code)?;
            code = code_at(body, position);
        }
        if code == Some(0x2e) || is_name_start(code) {
            return Err(self.error(
                position,
                format!(
                    "Invalid number, expected digit but got: {}.",
                    self.print_code_point_at(position)
                ),
            ));
        }
        Ok(Self::make_token(
            if is_float {
                TokenKind::Float
            } else {
                TokenKind::Int
            },
            start,
            position,
            Some(slice(body, start, position)),
        ))
    }

    /// `readDigits(lexer, start, firstCode)`: the position after one or
    /// more digits.
    fn read_digits(&self, start: usize, first_code: Option<u16>) -> Result<usize, GraphQlError> {
        if !is_digit(first_code) {
            return Err(self.error(
                start,
                format!(
                    "Invalid number, expected digit but got: {}.",
                    self.print_code_point_at(start)
                ),
            ));
        }
        let mut position = start + 1;
        while is_digit(code_at(&self.body, position)) {
            position += 1;
        }
        Ok(position)
    }

    /// `readString(lexer, start)`.
    fn read_string(&self, start: usize) -> Result<Token, GraphQlError> {
        let body = &self.body;
        let mut position = start + 1;
        let mut chunk_start = position;
        let mut value: Vec<u16> = Vec::new();
        while position < body.len() {
            let code = body[position];
            if code == 0x22 {
                value.extend_from_slice(&body[chunk_start..position]);
                return Ok(Self::make_token(
                    TokenKind::String,
                    start,
                    position + 1,
                    Some(String::from_utf16_lossy(&value)),
                ));
            }
            if code == 0x5c {
                value.extend_from_slice(&body[chunk_start..position]);
                let (escape, size) = if code_at(body, position + 1) == Some(0x75) {
                    if code_at(body, position + 2) == Some(0x7b) {
                        self.read_escaped_unicode_variable_width(position)?
                    } else {
                        self.read_escaped_unicode_fixed_width(position)?
                    }
                } else {
                    self.read_escaped_character(position)?
                };
                let mut units = [0u16; 2];
                value.extend_from_slice(escape.encode_utf16(&mut units));
                position += size;
                chunk_start = position;
                continue;
            }
            if code == 0x0a || code == 0x0d {
                break;
            }
            if is_unicode_scalar_value(i64::from(code)) {
                position += 1;
            } else if is_supplementary_code_point(body, position) {
                position += 2;
            } else {
                return Err(self.error(
                    position,
                    format!(
                        "Invalid character within String: {}.",
                        self.print_code_point_at(position)
                    ),
                ));
            }
        }
        Err(self.error(position, "Unterminated string."))
    }

    /// `readEscapedUnicodeVariableWidth(lexer, position)`: `\u{…}`.
    fn read_escaped_unicode_variable_width(
        &self,
        position: usize,
    ) -> Result<(char, usize), GraphQlError> {
        let body = &self.body;
        let mut point: i32 = 0;
        let mut size = 3;
        // Cannot be larger than 12 chars (\u{00000000}).
        while size < 12 {
            let code = code_at(body, position + size);
            size += 1;
            if code == Some(0x7d) {
                // At least 5 chars (\u{0}) and a Unicode scalar value.
                if size < 5 || !is_unicode_scalar_value(i64::from(point)) {
                    break;
                }
                return Ok((from_code_point(point.unsigned_abs()), size));
            }
            point = point.wrapping_shl(4) | read_hex_digit(code);
            if point < 0 {
                break;
            }
        }
        Err(self.error(
            position,
            format!(
                "Invalid Unicode escape sequence: \"{}\".",
                slice(body, position, position + size)
            ),
        ))
    }

    /// `readEscapedUnicodeFixedWidth(lexer, position)`: `\uXXXX`, or a
    /// surrogate pair of two of them.
    fn read_escaped_unicode_fixed_width(
        &self,
        position: usize,
    ) -> Result<(char, usize), GraphQlError> {
        let body = &self.body;
        let code = read_16_bit_hex_code(body, position + 2);
        if is_unicode_scalar_value(i64::from(code)) {
            return Ok((from_code_point(code.unsigned_abs()), 6));
        }
        if is_leading_surrogate(i64::from(code))
            && code_at(body, position + 6) == Some(0x5c)
            && code_at(body, position + 7) == Some(0x75)
        {
            let trailing_code = read_16_bit_hex_code(body, position + 8);
            if is_trailing_surrogate(i64::from(trailing_code)) {
                let point = 0x10000
                    + ((code.unsigned_abs() - 0xd800) << 10)
                    + (trailing_code.unsigned_abs() - 0xdc00);
                return Ok((from_code_point(point), 12));
            }
        }
        Err(self.error(
            position,
            format!(
                "Invalid Unicode escape sequence: \"{}\".",
                slice(body, position, position + 6)
            ),
        ))
    }

    /// `readEscapedCharacter(lexer, position)`.
    fn read_escaped_character(&self, position: usize) -> Result<(char, usize), GraphQlError> {
        let body = &self.body;
        let value = match code_at(body, position + 1) {
            Some(0x22) => '"',
            Some(0x5c) => '\\',
            Some(0x2f) => '/',
            Some(0x62) => '\u{8}',
            Some(0x66) => '\u{c}',
            Some(0x6e) => '\n',
            Some(0x72) => '\r',
            Some(0x74) => '\t',
            _ => {
                return Err(self.error(
                    position,
                    format!(
                        "Invalid character escape sequence: \"{}\".",
                        slice(body, position, position + 2)
                    ),
                ));
            }
        };
        Ok((value, 2))
    }

    /// `readBlockString(lexer, start)`.
    fn read_block_string(&self, start: usize) -> Result<Token, GraphQlError> {
        let body = &self.body;
        let mut position = start + 3;
        let mut chunk_start = position;
        let mut current_line: Vec<u16> = Vec::new();
        let mut block_lines: Vec<Vec<u16>> = Vec::new();
        while position < body.len() {
            let code = body[position];
            if code == 0x22
                && code_at(body, position + 1) == Some(0x22)
                && code_at(body, position + 2) == Some(0x22)
            {
                current_line.extend_from_slice(&body[chunk_start..position]);
                block_lines.push(current_line);
                let lines = dedent_block_string_lines(block_lines);
                let value = lines
                    .iter()
                    .map(|l| String::from_utf16_lossy(l))
                    .collect::<Vec<_>>()
                    .join("\n");
                return Ok(Self::make_token(
                    TokenKind::BlockString,
                    start,
                    position + 3,
                    Some(value),
                ));
            }
            if code == 0x5c
                && code_at(body, position + 1) == Some(0x22)
                && code_at(body, position + 2) == Some(0x22)
                && code_at(body, position + 3) == Some(0x22)
            {
                current_line.extend_from_slice(&body[chunk_start..position]);
                // Skip only the slash.
                chunk_start = position + 1;
                position += 4;
                continue;
            }
            if code == 0x0a || code == 0x0d {
                current_line.extend_from_slice(&body[chunk_start..position]);
                block_lines.push(std::mem::take(&mut current_line));
                position += if code == 0x0d && code_at(body, position + 1) == Some(0x0a) {
                    2
                } else {
                    1
                };
                chunk_start = position;
                continue;
            }
            if is_unicode_scalar_value(i64::from(code)) {
                position += 1;
            } else if is_supplementary_code_point(body, position) {
                position += 2;
            } else {
                return Err(self.error(
                    position,
                    format!(
                        "Invalid character within String: {}.",
                        self.print_code_point_at(position)
                    ),
                ));
            }
        }
        Err(self.error(position, "Unterminated string."))
    }

    /// `readName(lexer, start)`.
    fn read_name(&self, start: usize) -> Token {
        let body = &self.body;
        let mut position = start + 1;
        while position < body.len() && is_name_continue(Some(body[position])) {
            position += 1;
        }
        Self::make_token(
            TokenKind::Name,
            start,
            position,
            Some(slice(body, start, position)),
        )
    }
}

/// `read16BitHexCode(body, position)`: negative if any of the four is not
/// a hex digit.
fn read_16_bit_hex_code(body: &[u16], position: usize) -> i32 {
    (read_hex_digit(code_at(body, position)) << 12)
        | (read_hex_digit(code_at(body, position + 1)) << 8)
        | (read_hex_digit(code_at(body, position + 2)) << 4)
        | read_hex_digit(code_at(body, position + 3))
}

/// `readHexDigit(code)`: 0–15, or -1.
fn read_hex_digit(code: Option<u16>) -> i32 {
    match code {
        Some(c @ 0x30..=0x39) => i32::from(c) - 0x30,
        Some(c @ 0x41..=0x46) => i32::from(c) - 0x37,
        Some(c @ 0x61..=0x66) => i32::from(c) - 0x57,
        _ => -1,
    }
}

/// `dedentBlockStringLines(lines)`: removes the common indentation of all
/// lines but the first, then leading and trailing blank lines.
fn dedent_block_string_lines(lines: Vec<Vec<u16>>) -> Vec<Vec<u16>> {
    let mut common_indent = usize::MAX;
    let mut first_non_empty_line: Option<usize> = None;
    let mut last_non_empty_line: Option<usize> = None;
    for (i, line) in lines.iter().enumerate() {
        let indent = line.iter().take_while(|&&c| is_white_space(c)).count();
        if indent == line.len() {
            continue;
        }
        first_non_empty_line.get_or_insert(i);
        last_non_empty_line = Some(i);
        if i != 0 && indent < common_indent {
            common_indent = indent;
        }
    }
    let first = first_non_empty_line.unwrap_or(0);
    let end = last_non_empty_line.map_or(0, |l| l + 1);
    lines
        .into_iter()
        .enumerate()
        .map(|(i, line)| {
            if i == 0 {
                line
            } else {
                line[common_indent.min(line.len())..].to_vec()
            }
        })
        .skip(first)
        .take(end.saturating_sub(first))
        .collect()
}

#[cfg(test)]
mod tests {
    use super::*;

    fn tokens(source: &str) -> Result<Vec<(TokenKind, Option<String>)>, String> {
        let mut lexer = Lexer::new(source);
        let mut out = Vec::new();
        loop {
            let token = lexer.advance().map_err(|e| e.message().to_owned())?;
            out.push((token.kind, token.value.clone()));
            if token.kind == TokenKind::Eof {
                return Ok(out);
            }
        }
    }

    #[test]
    fn lexes_punctuators_names_and_numbers() {
        let t = tokens("{ a: b(x: -1.5e3) ...F } # c").unwrap();
        let kinds: Vec<TokenKind> = t.iter().map(|(k, _)| *k).collect();
        assert_eq!(
            kinds,
            [
                TokenKind::BraceL,
                TokenKind::Name,
                TokenKind::Colon,
                TokenKind::Name,
                TokenKind::ParenL,
                TokenKind::Name,
                TokenKind::Colon,
                TokenKind::Float,
                TokenKind::ParenR,
                TokenKind::Spread,
                TokenKind::Name,
                TokenKind::BraceR,
                TokenKind::Eof
            ]
        );
        assert_eq!(t[7].1.as_deref(), Some("-1.5e3"));
    }

    #[test]
    fn decodes_strings() {
        let t = tokens(r#""a\u0041\u{1F600}\uD83D\uDE00\n""#).unwrap();
        assert_eq!(t[0].1.as_deref(), Some("aA\u{1F600}\u{1F600}\n"));
        let t = tokens("\"\"\"\n    hello\n      world\n  \"\"\"").unwrap();
        assert_eq!(t[0].1.as_deref(), Some("hello\n  world"));
    }

    #[test]
    fn errors_use_graphql_js_texts() {
        let err = |s: &str| tokens(s).unwrap_err();
        assert_eq!(
            err("'"),
            "Syntax Error: Unexpected single quote character ('), did you mean to use a double quote (\")?"
        );
        assert_eq!(err("."), "Syntax Error: Unexpected character: \".\".");
        assert_eq!(err("\u{7}"), "Syntax Error: Unexpected character: U+0007.");
        assert_eq!(
            err("\u{1F600}"),
            "Syntax Error: Unexpected character: U+1F600."
        );
        assert_eq!(
            err("01"),
            "Syntax Error: Invalid number, unexpected digit after 0: \"1\"."
        );
        assert_eq!(
            err("1."),
            "Syntax Error: Invalid number, expected digit but got: <EOF>."
        );
        assert_eq!(
            err("1a"),
            "Syntax Error: Invalid number, expected digit but got: \"a\"."
        );
        assert_eq!(err("\"abc"), "Syntax Error: Unterminated string.");
        assert_eq!(
            err("\"\\x\""),
            "Syntax Error: Invalid character escape sequence: \"\\x\"."
        );
        assert_eq!(
            err("\"\\u{110000}\""),
            "Syntax Error: Invalid Unicode escape sequence: \"\\u{110000}\"."
        );
        assert_eq!(
            err("\"\\uD800\""),
            "Syntax Error: Invalid Unicode escape sequence: \"\\uD800\"."
        );
    }
}

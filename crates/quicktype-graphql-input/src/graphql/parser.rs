//! Port of graphql-js 16.14.2 `language/parser.js` (`parse(source)` with
//! default options).
//!
//! The grammar is graphql-js's in full, type system definitions and
//! extensions included, so exactly the documents graphql-js accepts parse,
//! and every rejected document fails with graphql-js's message at the same
//! token. Only the AST quicktype reads is built (see [`ast`](super::ast)).
//!
//! Like graphql-js the parser is recursive descent. Nesting is limited
//! only by memory: the stack grows on demand where graphql-js would
//! eventually overflow Node's stack (`docs/PARITY.md`, Known gaps).

use super::ast::{
    Definition, Document, Field, FragmentDefinition, FragmentSpread, InlineFragment,
    OperationDefinition, OperationType, Selection, SelectionSet,
};
use super::error::{GraphQlError, syntax_error};
use super::lexer::{Lexer, Token, TokenKind, token_desc, token_kind_desc};

type Result<T> = std::result::Result<T, GraphQlError>;

/// `DirectiveLocation`'s keys (`directiveLocation.js`).
const DIRECTIVE_LOCATIONS: [&str; 20] = [
    "QUERY",
    "MUTATION",
    "SUBSCRIPTION",
    "FIELD",
    "FRAGMENT_DEFINITION",
    "FRAGMENT_SPREAD",
    "INLINE_FRAGMENT",
    "VARIABLE_DEFINITION",
    "SCHEMA",
    "SCALAR",
    "OBJECT",
    "FIELD_DEFINITION",
    "ARGUMENT_DEFINITION",
    "INTERFACE",
    "UNION",
    "ENUM",
    "ENUM_VALUE",
    "INPUT_OBJECT",
    "INPUT_FIELD_DEFINITION",
    "DIRECTIVE_DEFINITION",
];

/// The stack kept free before a recursive rule continues on a new stack
/// segment.
const RED_ZONE: usize = 128 * 1024;

/// The size of each new stack segment.
const STACK_SEGMENT: usize = 2 * 1024 * 1024;

/// Runs a recursive rule, on a new stack segment if the stack is nearly
/// exhausted.
fn grow<R>(f: impl FnOnce() -> R) -> R {
    stacker::maybe_grow(RED_ZONE, STACK_SEGMENT, f)
}

/// `parse(source)`: the document, or graphql-js's `GraphQLError`.
///
/// ```
/// use quicktype_graphql_input::graphql::parse;
///
/// let document = parse("query Q { viewer { login } }").unwrap();
/// assert_eq!(document.definitions.len(), 1);
/// assert_eq!(
///     parse("{ viewer {").unwrap_err().message(),
///     "Syntax Error: Expected Name, found <EOF>."
/// );
/// ```
pub fn parse(source: &str) -> Result<Document> {
    Parser::new(source).parse_document()
}

/// The parser (`Parser`).
struct Parser {
    lexer: Lexer,
}

impl Parser {
    fn new(source: &str) -> Self {
        Parser {
            lexer: Lexer::new(source),
        }
    }

    fn token(&self) -> &Token {
        self.lexer.token()
    }

    /// `parseName()`: the name's value.
    fn parse_name(&mut self) -> Result<String> {
        let token = self.expect_token(TokenKind::Name)?;
        Ok(token.value.unwrap_or_default())
    }

    // ---- Document ---------------------------------------------------------

    /// `parseDocument()`.
    fn parse_document(&mut self) -> Result<Document> {
        let definitions = self.many(TokenKind::Sof, Self::parse_definition, TokenKind::Eof)?;
        Ok(Document { definitions })
    }

    /// `parseDefinition()`.
    fn parse_definition(&mut self) -> Result<Definition> {
        if self.peek(TokenKind::BraceL) {
            return Ok(Definition::Operation(self.parse_operation_definition()?));
        }
        // Many definitions begin with a description and require a lookahead.
        let has_description = self.peek_description();
        let keyword_token = if has_description {
            self.lexer.lookahead()?.clone()
        } else {
            self.token().clone()
        };
        if has_description && keyword_token.kind == TokenKind::BraceL {
            return Err(syntax_error(
                self.token().start,
                "Unexpected description, descriptions are not supported on shorthand queries.",
            ));
        }
        if keyword_token.kind == TokenKind::Name {
            match keyword_token.value.as_deref().unwrap_or_default() {
                "schema" => return self.parse_schema_definition(),
                "scalar" => return self.parse_scalar_type_definition(),
                "type" => return self.parse_object_type_definition(),
                "interface" => return self.parse_interface_type_definition(),
                "union" => return self.parse_union_type_definition(),
                "enum" => return self.parse_enum_type_definition(),
                "input" => return self.parse_input_object_type_definition(),
                "directive" => return self.parse_directive_definition(),
                "query" | "mutation" | "subscription" => {
                    return Ok(Definition::Operation(self.parse_operation_definition()?));
                }
                "fragment" => return Ok(Definition::Fragment(self.parse_fragment_definition()?)),
                _ => {}
            }
            if has_description {
                return Err(syntax_error(
                    self.token().start,
                    "Unexpected description, only GraphQL definitions support descriptions.",
                ));
            }
            if keyword_token.value.as_deref() == Some("extend") {
                return self.parse_type_system_extension();
            }
        }
        Err(self.unexpected(Some(&keyword_token)))
    }

    // ---- Operations -------------------------------------------------------

    /// `parseOperationDefinition()`.
    fn parse_operation_definition(&mut self) -> Result<OperationDefinition> {
        if self.peek(TokenKind::BraceL) {
            return Ok(OperationDefinition {
                operation: OperationType::Query,
                name: None,
                selection_set: self.parse_selection_set()?,
            });
        }
        self.parse_description()?;
        let operation = self.parse_operation_type()?;
        let name = if self.peek(TokenKind::Name) {
            Some(self.parse_name()?)
        } else {
            None
        };
        self.parse_variable_definitions()?;
        self.parse_directives(false)?;
        let selection_set = self.parse_selection_set()?;
        Ok(OperationDefinition {
            operation,
            name,
            selection_set,
        })
    }

    /// `parseOperationType()`.
    fn parse_operation_type(&mut self) -> Result<OperationType> {
        let operation_token = self.expect_token(TokenKind::Name)?;
        match operation_token.value.as_deref() {
            Some("query") => Ok(OperationType::Query),
            Some("mutation") => Ok(OperationType::Mutation),
            Some("subscription") => Ok(OperationType::Subscription),
            _ => Err(self.unexpected(Some(&operation_token))),
        }
    }

    /// `parseVariableDefinitions()`.
    fn parse_variable_definitions(&mut self) -> Result<()> {
        self.optional_many(
            TokenKind::ParenL,
            Self::parse_variable_definition,
            TokenKind::ParenR,
        )?;
        Ok(())
    }

    /// `parseVariableDefinition()`.
    fn parse_variable_definition(&mut self) -> Result<()> {
        self.parse_description()?;
        self.parse_variable()?;
        self.expect_token(TokenKind::Colon)?;
        self.parse_type_reference()?;
        if self.expect_optional_token(TokenKind::Equals)? {
            self.parse_const_value_literal()?;
        }
        self.parse_const_directives()?;
        Ok(())
    }

    /// `parseVariable()`.
    fn parse_variable(&mut self) -> Result<()> {
        self.expect_token(TokenKind::Dollar)?;
        self.parse_name()?;
        Ok(())
    }

    /// `parseSelectionSet()`.
    fn parse_selection_set(&mut self) -> Result<SelectionSet> {
        grow(|| {
            let selections =
                self.many(TokenKind::BraceL, Self::parse_selection, TokenKind::BraceR)?;
            Ok(SelectionSet { selections })
        })
    }

    /// `parseSelection()`.
    fn parse_selection(&mut self) -> Result<Selection> {
        if self.peek(TokenKind::Spread) {
            self.parse_fragment()
        } else {
            Ok(Selection::Field(self.parse_field()?))
        }
    }

    /// `parseField()`.
    fn parse_field(&mut self) -> Result<Field> {
        let name_or_alias = self.parse_name()?;
        let (alias, name) = if self.expect_optional_token(TokenKind::Colon)? {
            (Some(name_or_alias), self.parse_name()?)
        } else {
            (None, name_or_alias)
        };
        self.parse_arguments(false)?;
        let directives = self.parse_directives(false)?;
        let selection_set = if self.peek(TokenKind::BraceL) {
            Some(self.parse_selection_set()?)
        } else {
            None
        };
        Ok(Field {
            alias,
            name,
            directives,
            selection_set,
        })
    }

    /// `parseArguments(isConst)`.
    fn parse_arguments(&mut self, is_const: bool) -> Result<()> {
        self.optional_many(
            TokenKind::ParenL,
            |p| p.parse_argument(is_const),
            TokenKind::ParenR,
        )?;
        Ok(())
    }

    /// `parseArgument(isConst)`.
    fn parse_argument(&mut self, is_const: bool) -> Result<()> {
        self.parse_name()?;
        self.expect_token(TokenKind::Colon)?;
        self.parse_value_literal(is_const)
    }

    // ---- Fragments --------------------------------------------------------

    /// `parseFragment()`: a fragment spread or an inline fragment.
    fn parse_fragment(&mut self) -> Result<Selection> {
        self.expect_token(TokenKind::Spread)?;
        let has_type_condition = self.expect_optional_keyword("on")?;
        if !has_type_condition && self.peek(TokenKind::Name) {
            let name = self.parse_fragment_name()?;
            let directives = self.parse_directives(false)?;
            return Ok(Selection::FragmentSpread(FragmentSpread {
                name,
                directives,
            }));
        }
        let type_condition = if has_type_condition {
            Some(self.parse_named_type()?)
        } else {
            None
        };
        let directives = self.parse_directives(false)?;
        let selection_set = self.parse_selection_set()?;
        Ok(Selection::InlineFragment(InlineFragment {
            type_condition,
            directives,
            selection_set,
        }))
    }

    /// `parseFragmentDefinition()`.
    fn parse_fragment_definition(&mut self) -> Result<FragmentDefinition> {
        let has_description = self.parse_description()?;
        self.expect_keyword("fragment")?;
        let name = self.parse_fragment_name()?;
        self.expect_keyword("on")?;
        let type_condition = self.parse_named_type()?;
        let directives = self.parse_directives(false)?;
        let selection_set = self.parse_selection_set()?;
        Ok(FragmentDefinition {
            has_description,
            name,
            type_condition,
            directives,
            selection_set,
        })
    }

    /// `parseFragmentName()`: any name but `on`.
    fn parse_fragment_name(&mut self) -> Result<String> {
        if self.token().value.as_deref() == Some("on") {
            return Err(self.unexpected(None));
        }
        self.parse_name()
    }

    // ---- Values -----------------------------------------------------------

    /// `parseValueLiteral(isConst)`.
    fn parse_value_literal(&mut self, is_const: bool) -> Result<()> {
        grow(|| {
            let token = self.token().clone();
            match token.kind {
                TokenKind::BracketL => self.parse_list(is_const),
                TokenKind::BraceL => self.parse_object(is_const),
                TokenKind::Int | TokenKind::Float | TokenKind::Name => self.advance_lexer(),
                TokenKind::String | TokenKind::BlockString => self.parse_string_literal(),
                TokenKind::Dollar => {
                    if is_const {
                        self.expect_token(TokenKind::Dollar)?;
                        let after = self.token();
                        if after.kind == TokenKind::Name {
                            let var_name = after.value.clone().unwrap_or_default();
                            return Err(syntax_error(
                                token.start,
                                format!("Unexpected variable \"${var_name}\" in constant value."),
                            ));
                        }
                        return Err(self.unexpected(Some(&token)));
                    }
                    self.parse_variable()
                }
                _ => Err(self.unexpected(None)),
            }
        })
    }

    /// `parseConstValueLiteral()`.
    fn parse_const_value_literal(&mut self) -> Result<()> {
        self.parse_value_literal(true)
    }

    /// `parseStringLiteral()`.
    fn parse_string_literal(&mut self) -> Result<()> {
        self.advance_lexer()
    }

    /// `parseList(isConst)`.
    fn parse_list(&mut self, is_const: bool) -> Result<()> {
        self.any(
            TokenKind::BracketL,
            |p| p.parse_value_literal(is_const),
            TokenKind::BracketR,
        )?;
        Ok(())
    }

    /// `parseObject(isConst)`.
    fn parse_object(&mut self, is_const: bool) -> Result<()> {
        self.any(
            TokenKind::BraceL,
            |p| p.parse_object_field(is_const),
            TokenKind::BraceR,
        )?;
        Ok(())
    }

    /// `parseObjectField(isConst)`.
    fn parse_object_field(&mut self, is_const: bool) -> Result<()> {
        self.parse_name()?;
        self.expect_token(TokenKind::Colon)?;
        self.parse_value_literal(is_const)
    }

    // ---- Directives -------------------------------------------------------

    /// `parseDirectives(isConst)`: the directives' names.
    fn parse_directives(&mut self, is_const: bool) -> Result<Vec<String>> {
        let mut directives = Vec::new();
        while self.peek(TokenKind::At) {
            directives.push(self.parse_directive(is_const)?);
        }
        Ok(directives)
    }

    /// `parseConstDirectives()`; whether there were any.
    fn parse_const_directives(&mut self) -> Result<bool> {
        Ok(!self.parse_directives(true)?.is_empty())
    }

    /// `parseDirective(isConst)`: its name.
    fn parse_directive(&mut self, is_const: bool) -> Result<String> {
        self.expect_token(TokenKind::At)?;
        let name = self.parse_name()?;
        self.parse_arguments(is_const)?;
        Ok(name)
    }

    // ---- Types ------------------------------------------------------------

    /// `parseTypeReference()`.
    fn parse_type_reference(&mut self) -> Result<()> {
        grow(|| {
            if self.expect_optional_token(TokenKind::BracketL)? {
                self.parse_type_reference()?;
                self.expect_token(TokenKind::BracketR)?;
            } else {
                self.parse_named_type()?;
            }
            self.expect_optional_token(TokenKind::Bang)?;
            Ok(())
        })
    }

    /// `parseNamedType()`: the type's name.
    fn parse_named_type(&mut self) -> Result<String> {
        self.parse_name()
    }

    // ---- Type system definitions -------------------------------------------

    /// `peekDescription()`.
    fn peek_description(&self) -> bool {
        self.peek(TokenKind::String) || self.peek(TokenKind::BlockString)
    }

    /// `parseDescription()`: whether there was one.
    fn parse_description(&mut self) -> Result<bool> {
        if self.peek_description() {
            self.parse_string_literal()?;
            return Ok(true);
        }
        Ok(false)
    }

    /// `parseSchemaDefinition()`.
    fn parse_schema_definition(&mut self) -> Result<Definition> {
        self.parse_description()?;
        self.expect_keyword("schema")?;
        self.parse_const_directives()?;
        self.many(
            TokenKind::BraceL,
            Self::parse_operation_type_definition,
            TokenKind::BraceR,
        )?;
        Ok(Definition::TypeSystem)
    }

    /// `parseOperationTypeDefinition()`.
    fn parse_operation_type_definition(&mut self) -> Result<()> {
        self.parse_operation_type()?;
        self.expect_token(TokenKind::Colon)?;
        self.parse_named_type()?;
        Ok(())
    }

    /// `parseScalarTypeDefinition()`.
    fn parse_scalar_type_definition(&mut self) -> Result<Definition> {
        self.parse_description()?;
        self.expect_keyword("scalar")?;
        self.parse_name()?;
        self.parse_const_directives()?;
        Ok(Definition::TypeSystem)
    }

    /// `parseObjectTypeDefinition()`.
    fn parse_object_type_definition(&mut self) -> Result<Definition> {
        self.parse_description()?;
        self.expect_keyword("type")?;
        self.parse_name()?;
        self.parse_implements_interfaces()?;
        self.parse_const_directives()?;
        self.parse_fields_definition()?;
        Ok(Definition::TypeSystem)
    }

    /// `parseImplementsInterfaces()`; whether there were any.
    fn parse_implements_interfaces(&mut self) -> Result<bool> {
        if self.expect_optional_keyword("implements")? {
            self.delimited_many(TokenKind::Amp, Self::parse_named_type)?;
            return Ok(true);
        }
        Ok(false)
    }

    /// `parseFieldsDefinition()`; whether there were any.
    fn parse_fields_definition(&mut self) -> Result<bool> {
        let fields = self.optional_many(
            TokenKind::BraceL,
            Self::parse_field_definition,
            TokenKind::BraceR,
        )?;
        Ok(!fields.is_empty())
    }

    /// `parseFieldDefinition()`.
    fn parse_field_definition(&mut self) -> Result<()> {
        self.parse_description()?;
        self.parse_name()?;
        self.parse_argument_defs()?;
        self.expect_token(TokenKind::Colon)?;
        self.parse_type_reference()?;
        self.parse_const_directives()?;
        Ok(())
    }

    /// `parseArgumentDefs()`.
    fn parse_argument_defs(&mut self) -> Result<()> {
        self.optional_many(
            TokenKind::ParenL,
            Self::parse_input_value_def,
            TokenKind::ParenR,
        )?;
        Ok(())
    }

    /// `parseInputValueDef()`.
    fn parse_input_value_def(&mut self) -> Result<()> {
        self.parse_description()?;
        self.parse_name()?;
        self.expect_token(TokenKind::Colon)?;
        self.parse_type_reference()?;
        if self.expect_optional_token(TokenKind::Equals)? {
            self.parse_const_value_literal()?;
        }
        self.parse_const_directives()?;
        Ok(())
    }

    /// `parseInterfaceTypeDefinition()`.
    fn parse_interface_type_definition(&mut self) -> Result<Definition> {
        self.parse_description()?;
        self.expect_keyword("interface")?;
        self.parse_name()?;
        self.parse_implements_interfaces()?;
        self.parse_const_directives()?;
        self.parse_fields_definition()?;
        Ok(Definition::TypeSystem)
    }

    /// `parseUnionTypeDefinition()`.
    fn parse_union_type_definition(&mut self) -> Result<Definition> {
        self.parse_description()?;
        self.expect_keyword("union")?;
        self.parse_name()?;
        self.parse_const_directives()?;
        self.parse_union_member_types()?;
        Ok(Definition::TypeSystem)
    }

    /// `parseUnionMemberTypes()`; whether there were any.
    fn parse_union_member_types(&mut self) -> Result<bool> {
        if self.expect_optional_token(TokenKind::Equals)? {
            self.delimited_many(TokenKind::Pipe, Self::parse_named_type)?;
            return Ok(true);
        }
        Ok(false)
    }

    /// `parseEnumTypeDefinition()`.
    fn parse_enum_type_definition(&mut self) -> Result<Definition> {
        self.parse_description()?;
        self.expect_keyword("enum")?;
        self.parse_name()?;
        self.parse_const_directives()?;
        self.parse_enum_values_definition()?;
        Ok(Definition::TypeSystem)
    }

    /// `parseEnumValuesDefinition()`; whether there were any.
    fn parse_enum_values_definition(&mut self) -> Result<bool> {
        let values = self.optional_many(
            TokenKind::BraceL,
            Self::parse_enum_value_definition,
            TokenKind::BraceR,
        )?;
        Ok(!values.is_empty())
    }

    /// `parseEnumValueDefinition()`.
    fn parse_enum_value_definition(&mut self) -> Result<()> {
        self.parse_description()?;
        self.parse_enum_value_name()?;
        self.parse_const_directives()?;
        Ok(())
    }

    /// `parseEnumValueName()`: any name but `true`, `false` and `null`.
    fn parse_enum_value_name(&mut self) -> Result<String> {
        let token = self.token();
        if matches!(token.value.as_deref(), Some("true" | "false" | "null")) {
            return Err(syntax_error(
                token.start,
                format!(
                    "{} is reserved and cannot be used for an enum value.",
                    token_desc(token)
                ),
            ));
        }
        self.parse_name()
    }

    /// `parseInputObjectTypeDefinition()`.
    fn parse_input_object_type_definition(&mut self) -> Result<Definition> {
        self.parse_description()?;
        self.expect_keyword("input")?;
        self.parse_name()?;
        self.parse_const_directives()?;
        self.parse_input_fields_definition()?;
        Ok(Definition::TypeSystem)
    }

    /// `parseInputFieldsDefinition()`; whether there were any.
    fn parse_input_fields_definition(&mut self) -> Result<bool> {
        let fields = self.optional_many(
            TokenKind::BraceL,
            Self::parse_input_value_def,
            TokenKind::BraceR,
        )?;
        Ok(!fields.is_empty())
    }

    /// `parseTypeSystemExtension()`.
    fn parse_type_system_extension(&mut self) -> Result<Definition> {
        let keyword_token = self.lexer.lookahead()?.clone();
        if keyword_token.kind == TokenKind::Name {
            match keyword_token.value.as_deref().unwrap_or_default() {
                "schema" => return self.parse_schema_extension(),
                "scalar" => return self.parse_scalar_type_extension(),
                "type" => return self.parse_object_type_extension("type"),
                "interface" => return self.parse_object_type_extension("interface"),
                "union" => return self.parse_union_type_extension(),
                "enum" => return self.parse_enum_type_extension(),
                "input" => return self.parse_input_object_type_extension(),
                // `extend directive` needs `experimentalDirectivesOnDirectiveDefinitions`.
                _ => {}
            }
        }
        Err(self.unexpected(Some(&keyword_token)))
    }

    /// `parseSchemaExtension()`.
    fn parse_schema_extension(&mut self) -> Result<Definition> {
        self.expect_keyword("extend")?;
        self.expect_keyword("schema")?;
        let directives = self.parse_const_directives()?;
        let operation_types = self.optional_many(
            TokenKind::BraceL,
            Self::parse_operation_type_definition,
            TokenKind::BraceR,
        )?;
        if !directives && operation_types.is_empty() {
            return Err(self.unexpected(None));
        }
        Ok(Definition::TypeSystem)
    }

    /// `parseScalarTypeExtension()`.
    fn parse_scalar_type_extension(&mut self) -> Result<Definition> {
        self.expect_keyword("extend")?;
        self.expect_keyword("scalar")?;
        self.parse_name()?;
        if !self.parse_const_directives()? {
            return Err(self.unexpected(None));
        }
        Ok(Definition::TypeSystem)
    }

    /// `parseObjectTypeExtension()` and `parseInterfaceTypeExtension()`,
    /// which differ only in the keyword.
    fn parse_object_type_extension(&mut self, keyword: &str) -> Result<Definition> {
        self.expect_keyword("extend")?;
        self.expect_keyword(keyword)?;
        self.parse_name()?;
        let interfaces = self.parse_implements_interfaces()?;
        let directives = self.parse_const_directives()?;
        let fields = self.parse_fields_definition()?;
        if !interfaces && !directives && !fields {
            return Err(self.unexpected(None));
        }
        Ok(Definition::TypeSystem)
    }

    /// `parseUnionTypeExtension()`.
    fn parse_union_type_extension(&mut self) -> Result<Definition> {
        self.expect_keyword("extend")?;
        self.expect_keyword("union")?;
        self.parse_name()?;
        let directives = self.parse_const_directives()?;
        let types = self.parse_union_member_types()?;
        if !directives && !types {
            return Err(self.unexpected(None));
        }
        Ok(Definition::TypeSystem)
    }

    /// `parseEnumTypeExtension()`.
    fn parse_enum_type_extension(&mut self) -> Result<Definition> {
        self.expect_keyword("extend")?;
        self.expect_keyword("enum")?;
        self.parse_name()?;
        let directives = self.parse_const_directives()?;
        let values = self.parse_enum_values_definition()?;
        if !directives && !values {
            return Err(self.unexpected(None));
        }
        Ok(Definition::TypeSystem)
    }

    /// `parseInputObjectTypeExtension()`.
    fn parse_input_object_type_extension(&mut self) -> Result<Definition> {
        self.expect_keyword("extend")?;
        self.expect_keyword("input")?;
        self.parse_name()?;
        let directives = self.parse_const_directives()?;
        let fields = self.parse_input_fields_definition()?;
        if !directives && !fields {
            return Err(self.unexpected(None));
        }
        Ok(Definition::TypeSystem)
    }

    /// `parseDirectiveDefinition()`.
    fn parse_directive_definition(&mut self) -> Result<Definition> {
        self.parse_description()?;
        self.expect_keyword("directive")?;
        self.expect_token(TokenKind::At)?;
        self.parse_name()?;
        self.parse_argument_defs()?;
        // Directives here need `experimentalDirectivesOnDirectiveDefinitions`.
        self.expect_optional_keyword("repeatable")?;
        self.expect_keyword("on")?;
        self.delimited_many(TokenKind::Pipe, Self::parse_directive_location)?;
        Ok(Definition::TypeSystem)
    }

    /// `parseDirectiveLocation()`.
    fn parse_directive_location(&mut self) -> Result<()> {
        let start = self.token().clone();
        let name = self.parse_name()?;
        if DIRECTIVE_LOCATIONS.contains(&name.as_str()) {
            return Ok(());
        }
        Err(self.unexpected(Some(&start)))
    }

    // ---- Core parsing utility functions -------------------------------------

    /// `peek(kind)`.
    fn peek(&self, kind: TokenKind) -> bool {
        self.token().kind == kind
    }

    /// `expectToken(kind)`: the current token, if it is of `kind`, and
    /// advances.
    fn expect_token(&mut self, kind: TokenKind) -> Result<Token> {
        let token = self.token().clone();
        if token.kind == kind {
            self.advance_lexer()?;
            return Ok(token);
        }
        Err(syntax_error(
            token.start,
            format!(
                "Expected {}, found {}.",
                token_kind_desc(kind),
                token_desc(&token)
            ),
        ))
    }

    /// `expectOptionalToken(kind)`.
    fn expect_optional_token(&mut self, kind: TokenKind) -> Result<bool> {
        if self.token().kind == kind {
            self.advance_lexer()?;
            return Ok(true);
        }
        Ok(false)
    }

    /// `expectKeyword(value)`.
    fn expect_keyword(&mut self, value: &str) -> Result<()> {
        let token = self.token();
        if token.kind == TokenKind::Name && token.value.as_deref() == Some(value) {
            return self.advance_lexer();
        }
        Err(syntax_error(
            token.start,
            format!("Expected \"{value}\", found {}.", token_desc(token)),
        ))
    }

    /// `expectOptionalKeyword(value)`.
    fn expect_optional_keyword(&mut self, value: &str) -> Result<bool> {
        let token = self.token();
        if token.kind == TokenKind::Name && token.value.as_deref() == Some(value) {
            self.advance_lexer()?;
            return Ok(true);
        }
        Ok(false)
    }

    /// `unexpected(atToken)`: the error for `at_token`, or for the current
    /// token.
    fn unexpected(&self, at_token: Option<&Token>) -> GraphQlError {
        let token = at_token.unwrap_or_else(|| self.token());
        syntax_error(token.start, format!("Unexpected {}.", token_desc(token)))
    }

    /// `any(openKind, parseFn, closeKind)`: zero or more.
    fn any<T>(
        &mut self,
        open_kind: TokenKind,
        mut parse_fn: impl FnMut(&mut Self) -> Result<T>,
        close_kind: TokenKind,
    ) -> Result<Vec<T>> {
        self.expect_token(open_kind)?;
        let mut nodes = Vec::new();
        while !self.expect_optional_token(close_kind)? {
            nodes.push(parse_fn(self)?);
        }
        Ok(nodes)
    }

    /// `optionalMany(openKind, parseFn, closeKind)`: nothing without the
    /// opening token, else one or more.
    fn optional_many<T>(
        &mut self,
        open_kind: TokenKind,
        mut parse_fn: impl FnMut(&mut Self) -> Result<T>,
        close_kind: TokenKind,
    ) -> Result<Vec<T>> {
        if self.expect_optional_token(open_kind)? {
            let mut nodes = Vec::new();
            loop {
                nodes.push(parse_fn(self)?);
                if self.expect_optional_token(close_kind)? {
                    return Ok(nodes);
                }
            }
        }
        Ok(Vec::new())
    }

    /// `many(openKind, parseFn, closeKind)`: one or more.
    fn many<T>(
        &mut self,
        open_kind: TokenKind,
        mut parse_fn: impl FnMut(&mut Self) -> Result<T>,
        close_kind: TokenKind,
    ) -> Result<Vec<T>> {
        self.expect_token(open_kind)?;
        let mut nodes = Vec::new();
        loop {
            nodes.push(parse_fn(self)?);
            if self.expect_optional_token(close_kind)? {
                return Ok(nodes);
            }
        }
    }

    /// `delimitedMany(delimiterKind, parseFn)`: one or more, separated (and
    /// optionally preceded) by the delimiter.
    fn delimited_many<T>(
        &mut self,
        delimiter_kind: TokenKind,
        mut parse_fn: impl FnMut(&mut Self) -> Result<T>,
    ) -> Result<Vec<T>> {
        self.expect_optional_token(delimiter_kind)?;
        let mut nodes = Vec::new();
        loop {
            nodes.push(parse_fn(self)?);
            if !self.expect_optional_token(delimiter_kind)? {
                return Ok(nodes);
            }
        }
    }

    /// `advanceLexer()` (without `maxTokens`, which quicktype does not set).
    fn advance_lexer(&mut self) -> Result<()> {
        self.lexer.advance()?;
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn error(source: &str) -> String {
        parse(source).unwrap_err().message().to_owned()
    }

    #[test]
    fn parses_operations_and_fragments() {
        let document = parse(
            "query Q($a: [Int!]! = [1]) @d { x: a(b: {c: $a}) @include(if: true) { ...F ... on T { c } } }\n\
             fragment F on T { d }\n\
             type T { a: Int }",
        )
        .unwrap();
        assert_eq!(document.definitions.len(), 3);
        let Definition::Operation(op) = &document.definitions[0] else {
            panic!("an operation");
        };
        assert_eq!(op.name.as_deref(), Some("Q"));
        let Selection::Field(field) = &op.selection_set.selections[0] else {
            panic!("a field");
        };
        assert_eq!(field.alias.as_deref(), Some("x"));
        assert_eq!(field.name, "a");
        assert_eq!(field.directives, ["include"]);
        assert_eq!(document.definitions[2], Definition::TypeSystem);
    }

    #[test]
    fn errors_use_graphql_js_texts() {
        assert_eq!(error(""), "Syntax Error: Unexpected <EOF>.");
        assert_eq!(error("{"), "Syntax Error: Expected Name, found <EOF>.");
        assert_eq!(
            error("{ a(x: $v) }x"),
            "Syntax Error: Unexpected Name \"x\"."
        );
        assert_eq!(
            error("query Q($a: Int = $b) { a }"),
            "Syntax Error: Unexpected variable \"$b\" in constant value."
        );
        assert_eq!(
            error("fragment on on T { a }"),
            "Syntax Error: Unexpected Name \"on\"."
        );
        assert_eq!(
            error("\"d\" { a }"),
            "Syntax Error: Unexpected description, descriptions are not supported on shorthand queries."
        );
        assert_eq!(
            error("enum E { true }"),
            "Syntax Error: Name \"true\" is reserved and cannot be used for an enum value."
        );
        assert_eq!(
            error("directive @d on FOO"),
            "Syntax Error: Unexpected Name \"FOO\"."
        );
        assert_eq!(error("extend type T"), "Syntax Error: Unexpected <EOF>.");
        assert_eq!(error("{ a(b: ) }"), "Syntax Error: Unexpected \")\".");
        assert_eq!(
            error("query { a } fragment F T { a }"),
            "Syntax Error: Expected \"on\", found Name \"T\"."
        );
    }
}

//! Port of the parts of graphql-js 16.14.2 `language/ast.d.ts` that
//! quicktype reads: operations, fragments and selection sets.
//!
//! The parser accepts every document graphql-js accepts, type system
//! definitions included, but keeps only what quicktype's GraphQL input
//! looks at: names, aliases, directive names, type conditions and nesting.
//! Arguments, values, variables and locations are checked and dropped.

/// `DocumentNode`.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct Document {
    /// `definitions`, in source order.
    pub definitions: Vec<Definition>,
}

/// `DefinitionNode`.
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum Definition {
    /// `OperationDefinitionNode`.
    Operation(OperationDefinition),
    /// `FragmentDefinitionNode`.
    Fragment(FragmentDefinition),
    /// Any type system definition or extension (`schema`, `type`,
    /// `extend type`, `directive`, ...).
    TypeSystem,
}

/// `OperationTypeNode`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum OperationType {
    /// `query`
    Query,
    /// `mutation`
    Mutation,
    /// `subscription`
    Subscription,
}

impl OperationType {
    /// The value graphql-js uses (`"query"`, ...).
    pub fn as_str(self) -> &'static str {
        match self {
            OperationType::Query => "query",
            OperationType::Mutation => "mutation",
            OperationType::Subscription => "subscription",
        }
    }
}

/// `OperationDefinitionNode`.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct OperationDefinition {
    /// `operation`.
    pub operation: OperationType,
    /// `name.value`, if the operation has a name.
    pub name: Option<String>,
    /// `selectionSet`.
    pub selection_set: SelectionSet,
}

/// `FragmentDefinitionNode`.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct FragmentDefinition {
    /// Whether the fragment has a `description`.
    pub has_description: bool,
    /// `name.value`.
    pub name: String,
    /// `typeCondition.name.value`.
    pub type_condition: String,
    /// The names of `directives`.
    pub directives: Vec<String>,
    /// `selectionSet`.
    pub selection_set: SelectionSet,
}

/// `SelectionSetNode`.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct SelectionSet {
    /// `selections`, in source order.
    pub selections: Vec<Selection>,
}

/// `SelectionNode`.
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum Selection {
    /// `FieldNode`.
    Field(Field),
    /// `FragmentSpreadNode`.
    FragmentSpread(FragmentSpread),
    /// `InlineFragmentNode`.
    InlineFragment(InlineFragment),
}

impl Selection {
    /// The names of the selection's `directives`.
    pub fn directives(&self) -> &[String] {
        match self {
            Selection::Field(f) => &f.directives,
            Selection::FragmentSpread(f) => &f.directives,
            Selection::InlineFragment(f) => &f.directives,
        }
    }
}

/// `FieldNode`.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Field {
    /// `alias.value`, if the field has an alias.
    pub alias: Option<String>,
    /// `name.value`.
    pub name: String,
    /// The names of `directives`.
    pub directives: Vec<String>,
    /// `selectionSet`, if the field has one.
    pub selection_set: Option<SelectionSet>,
}

/// `FragmentSpreadNode`.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct FragmentSpread {
    /// `name.value`.
    pub name: String,
    /// The names of `directives`.
    pub directives: Vec<String>,
}

/// `InlineFragmentNode`.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct InlineFragment {
    /// `typeCondition.name.value`, if the fragment has a type condition.
    pub type_condition: Option<String>,
    /// The names of `directives`.
    pub directives: Vec<String>,
    /// `selectionSet`.
    pub selection_set: SelectionSet,
}

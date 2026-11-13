//! Port of `packages/quicktype-graphql-input/src/GraphQLSchema.ts`.
//!
//! The TypeScript file was generated from the introspection schema: two
//! enums and the type of an introspection query result. The result type
//! has no runtime existence (the input reads the JSON as it is, see
//! [`crate`]); the enums are here.

/// `__DirectiveLocation`: where a directive can appear.
#[allow(non_camel_case_types)]
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum DirectiveLocation {
    /// Location adjacent to a query operation.
    QUERY,
    /// Location adjacent to a mutation operation.
    MUTATION,
    /// Location adjacent to a subscription operation.
    SUBSCRIPTION,
    /// Location adjacent to a field.
    FIELD,
    /// Location adjacent to a fragment definition.
    FRAGMENT_DEFINITION,
    /// Location adjacent to a fragment spread.
    FRAGMENT_SPREAD,
    /// Location adjacent to an inline fragment.
    INLINE_FRAGMENT,
    /// Location adjacent to a schema definition.
    SCHEMA,
    /// Location adjacent to a scalar definition.
    SCALAR,
    /// Location adjacent to an object type definition.
    OBJECT,
    /// Location adjacent to a field definition.
    FIELD_DEFINITION,
    /// Location adjacent to an argument definition.
    ARGUMENT_DEFINITION,
    /// Location adjacent to an interface definition.
    INTERFACE,
    /// Location adjacent to a union definition.
    UNION,
    /// Location adjacent to an enum definition.
    ENUM,
    /// Location adjacent to an enum value definition.
    ENUM_VALUE,
    /// Location adjacent to an input object type definition.
    INPUT_OBJECT,
    /// Location adjacent to an input object field definition.
    INPUT_FIELD_DEFINITION,
}

/// `TypeKind`: what kind of type a `__Type` is.
#[allow(non_camel_case_types)]
#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub enum TypeKind {
    /// Indicates this type is a scalar.
    SCALAR,
    /// Indicates this type is an object. `fields` and `interfaces` are
    /// valid fields.
    OBJECT,
    /// Indicates this type is an interface. `fields` and `possibleTypes`
    /// are valid fields.
    INTERFACE,
    /// Indicates this type is a union. `possibleTypes` is a valid field.
    UNION,
    /// Indicates this type is an enum. `enumValues` is a valid field.
    ENUM,
    /// Indicates this type is an input object. `inputFields` is a valid
    /// field.
    INPUT_OBJECT,
    /// Indicates this type is a list. `ofType` is a valid field.
    LIST,
    /// Indicates this type is a non-null. `ofType` is a valid field.
    NON_NULL,
}

impl TypeKind {
    /// Every kind, in declaration order.
    pub const ALL: [TypeKind; 8] = [
        TypeKind::SCALAR,
        TypeKind::OBJECT,
        TypeKind::INTERFACE,
        TypeKind::UNION,
        TypeKind::ENUM,
        TypeKind::INPUT_OBJECT,
        TypeKind::LIST,
        TypeKind::NON_NULL,
    ];

    /// The enum member's string value, e.g. `"NON_NULL"`.
    pub fn as_str(self) -> &'static str {
        match self {
            TypeKind::SCALAR => "SCALAR",
            TypeKind::OBJECT => "OBJECT",
            TypeKind::INTERFACE => "INTERFACE",
            TypeKind::UNION => "UNION",
            TypeKind::ENUM => "ENUM",
            TypeKind::INPUT_OBJECT => "INPUT_OBJECT",
            TypeKind::LIST => "LIST",
            TypeKind::NON_NULL => "NON_NULL",
        }
    }

    /// The kind whose string value is `s` (`===` comparison).
    pub fn from_value(s: &str) -> Option<TypeKind> {
        TypeKind::ALL.into_iter().find(|k| k.as_str() == s)
    }
}

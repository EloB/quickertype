//! Port of `packages/quicktype-core/src/language/Objective-C/constants.ts`.

/// `keywords`: names that generated types, properties, enum cases and union
/// members must not take.
pub const KEYWORDS: [&str; 43] = [
    // "_Bool",
    // "_Complex",
    // "_Imaginary",
    "asm",
    "atomic",
    "auto",
    "bool",
    "break",
    "case",
    "char",
    "const",
    "continue",
    "default",
    "do",
    "double",
    "else",
    "enum",
    "extern",
    "false",
    "float",
    "for",
    "goto",
    "if",
    "inline",
    "int",
    "long",
    "nil",
    "nonatomic",
    "register",
    "restrict",
    "retain",
    "return",
    "short",
    "signed",
    "sizeof",
    "static",
    "struct",
    "switch",
    "typedef",
    "typeof",
    "true",
    "union",
    "unsigned",
    "void",
    "volatile",
    "while",
];

/// `forbiddenPropertyNames`: property names that clash with `NSObject`.
pub const FORBIDDEN_PROPERTY_NAMES: [&str; 9] = [
    "id",
    "hash",
    "description",
    "init",
    "copy",
    "mutableCopy",
    "superclass",
    "debugDescription",
    "new",
];

/// `booleanPrefixes`: the words a boolean property name may start with.
pub const BOOLEAN_PREFIXES: [&str; 17] = [
    "is", "are", "were", "was", "will", "all", "some", "many", "has", "have", "had", "does", "do",
    "requires", "require", "needs", "need",
];

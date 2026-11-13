//! Port of `packages/quicktype-core/src/language/Scala3/constants.ts`.

/// `invalidSymbols`: a name containing one of these is backticked (the
/// list has a duplicate `":"`, as in TypeScript).
pub const INVALID_SYMBOLS: [&str; 26] = [
    "?", ":", "-", "+", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", ">", "<", "/", ";", "'",
    "\"", "{", "}", ":", "~", "`", ".",
];

/// `forbiddenPropertyNames`: `java.lang.Object` methods a property must not
/// shadow.
pub const FORBIDDEN_PROPERTY_NAMES: [&str; 10] = [
    "clone",
    "equals",
    "finalize",
    "getClass",
    "hashCode",
    "notify",
    "notifyAll",
    "synchronized",
    "toString",
    "wait",
];

/// `keywords`: reserved words and standard type names.
pub const KEYWORDS: [&str; 56] = [
    "abstract",
    "case",
    "catch",
    "class",
    "def",
    "do",
    "else",
    "enum",
    "extends",
    "export",
    "false",
    "final",
    "finally",
    "for",
    "forSome",
    "if",
    "implicit",
    "import",
    "lazy",
    "match",
    "new",
    "null",
    "object",
    "override",
    "package",
    "private",
    "protected",
    "return",
    "sealed",
    "super",
    "this",
    "then",
    "throw",
    "trait",
    "try",
    "true",
    "type",
    "val",
    "var",
    "while",
    "with",
    "yield",
    "Any",
    "Boolean",
    "Double",
    "Float",
    "Long",
    "Int",
    "Short",
    "System",
    "Byte",
    "String",
    "Array",
    "List",
    "Map",
    "Enum",
];

/// `forbiddenTypeNames`: names the generated code itself uses.
pub const FORBIDDEN_TYPE_NAMES: [&str; 12] = [
    "None",
    "Null",
    "Option",
    "Seq",
    "Json",
    "Encoder",
    "Decoder",
    "Codec",
    "NullValue",
    "OptionPickler",
    "JsonExt",
    "Exception",
];

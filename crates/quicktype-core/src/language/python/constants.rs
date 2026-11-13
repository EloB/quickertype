//! Port of `packages/quicktype-core/src/language/Python/constants.ts`.

/// `forbiddenTypeNames`.
pub const FORBIDDEN_TYPE_NAMES: [&str; 17] = [
    "Any", "True", "False", "None", "Enum", "List", "list", "Dict", "dict", "Optional", "Union",
    "UUID", "Iterable", "Type", "TypeVar", "T", "EnumT",
];

/// `forbiddenPropertyNames`.
pub const FORBIDDEN_PROPERTY_NAMES: [&str; 40] = [
    "and", "as", "assert", "async", "await", "bool", "break", "class", "continue", "datetime",
    "def", "del", "dict", "elif", "else", "except", "finally", "float", "for", "from", "global",
    "if", "import", "in", "int", "is", "lambda", "nonlocal", "not", "or", "pass", "print", "raise",
    "return", "self", "str", "try", "while", "with", "yield",
];

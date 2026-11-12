// To parse this data:
//
//   const Convert = require("./TopLevel");
//
//   const topLevel = Convert.toTopLevel(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
function toTopLevel(json) {
    return cast(JSON.parse(json), r("TopLevel"));
}

function topLevelToJson(value) {
    return JSON.stringify(uncast(value, r("TopLevel")), null, 2);
}

function invalidValue(typ, val, key, parent = '') {
    const prettyTyp = prettyTypeName(typ);
    const parentText = parent ? ` on ${parent}` : '';
    const keyText = key ? ` for key "${key}"` : '';
    throw Error(`Invalid value${keyText}${parentText}. Expected ${prettyTyp} but got ${JSON.stringify(val)}`);
}

function prettyTypeName(typ) {
    if (Array.isArray(typ)) {
        if (typ.length === 2 && typ[0] === undefined) {
            return `an optional ${prettyTypeName(typ[1])}`;
        } else {
            return `one of [${typ.map(a => { return prettyTypeName(a); }).join(", ")}]`;
        }
    } else if (typeof typ === "object" && typ.literal !== undefined) {
        return typ.literal;
    } else {
        return typeof typ;
    }
}

function jsonToJSProps(typ) {
    if (typ.jsonToJS === undefined) {
        const map = {};
        typ.props.forEach((p) => map[p.json] = { key: p.js, typ: p.typ });
        typ.jsonToJS = map;
    }
    return typ.jsonToJS;
}

function jsToJSONProps(typ) {
    if (typ.jsToJSON === undefined) {
        const map = {};
        typ.props.forEach((p) => map[p.js] = { key: p.json, typ: p.typ });
        typ.jsToJSON = map;
    }
    return typ.jsToJSON;
}

function transform(val, typ, getProps, key = '', parent = '') {
    function transformPrimitive(typ, val) {
        if (typeof typ === typeof val) return val;
        return invalidValue(typ, val, key, parent);
    }

    function transformUnion(typs, val) {
        // val must validate against one typ in typs
        const l = typs.length;
        for (let i = 0; i < l; i++) {
            const typ = typs[i];
            try {
                return transform(val, typ, getProps);
            } catch (_) {}
        }
        return invalidValue(typs, val, key, parent);
    }

    function transformEnum(cases, val) {
        if (cases.indexOf(val) !== -1) return val;
        return invalidValue(cases.map(a => { return l(a); }), val, key, parent);
    }

    function transformArray(typ, val) {
        // val must be an array with no invalid elements
        if (!Array.isArray(val)) return invalidValue(l("array"), val, key, parent);

        return val.map(el => transform(el, typ, getProps));
    }

    function transformDate(val) {
        if (val === null) {
            return null;
        }
        const d = new Date(val);
        if (isNaN(d.valueOf())) {
            return invalidValue(l("Date"), val, key, parent);
        }
        return d;
    }

    function transformObject(props, additional, val) {
        if (val === null || typeof val !== "object" || Array.isArray(val)) {
            return invalidValue(l(ref || "object"), val, key, parent);
        }
        const result = {};
        Object.getOwnPropertyNames(props).forEach(key => {
            const prop = props[key];
            const v = Object.prototype.hasOwnProperty.call(val, key) ? val[key] : undefined;
            result[prop.key] = transform(v, prop.typ, getProps, key, ref);
        });
        Object.getOwnPropertyNames(val).forEach(key => {
            if (!Object.prototype.hasOwnProperty.call(props, key)) {
                result[key] = transform(val[key], additional, getProps, key, ref);
            }
        });
        return result;
    }

    if (typ === "any") return val;
    if (typ === null) {
        if (val === null) return val;
        return invalidValue(typ, val, key, parent);
    }
    if (typ === false) return invalidValue(typ, val, key, parent);
    let ref = undefined;
    while (typeof typ === "object" && typ.ref !== undefined) {
        ref = typ.ref;
        typ = typeMap[typ.ref];
    }
    if (Array.isArray(typ)) return transformEnum(typ, val);
    if (typeof typ === "object") {
        return typ.hasOwnProperty("pattern")      ? typeof val === "string" && new RegExp(typ.pattern).test(val) ? val : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("string")       ? typeof val === "string" && (typ.min === undefined || Array.from(val).length >= typ.min) && (typ.max === undefined || Array.from(val).length <= typ.max) ? transform(val, typ.string, getProps, key, parent) : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("number")       ? typeof val === "number" && (typ.min === undefined || val >= typ.min) && (typ.max === undefined || val <= typ.max) ? transform(val, typ.number, getProps, key, parent) : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("integer")      ? typeof val === "number" && val % 1 === 0 ? val : invalidValue(l("integer"), val, key, parent)
            : typ.hasOwnProperty("unionMembers") ? transformUnion(typ.unionMembers, val)
            : typ.hasOwnProperty("arrayItems")    ? transformArray(typ.arrayItems, val)
            : typ.hasOwnProperty("props")         ? transformObject(getProps(typ), typ.additional, val)
            : invalidValue(typ, val, key, parent);
    }
    // Numbers can be parsed by Date but shouldn't be.
    if (typ === Date && (typeof val === "string" || val instanceof Date)) return transformDate(val);
    return transformPrimitive(typ, val);
}

function cast(val, typ) {
    return transform(val, typ, jsonToJSProps);
}

function uncast(val, typ) {
    return transform(val, typ, jsToJSONProps);
}

function l(typ) {
    return { literal: typ };
}

function a(typ) {
    return { arrayItems: typ };
}

function i(typ) {
    return { integer: typ };
}

function p(pattern) {
    return { pattern };
}

function s(typ, min, max) {
    return { string: typ, min, max };
}

function n(typ, min, max) {
    return { number: typ, min, max };
}

function u(...typs) {
    return { unionMembers: typs };
}

function o(props, additional) {
    return { props, additional };
}

function m(additional) {
    const props = [];
    return { props, additional };
}

function r(name) {
    return { ref: name };
}

const typeMap = {
    "TopLevel": o([
        { json: "enum", js: "enum", typ: u(undefined, r("Enum")) },
    ], "any"),
    "Enum": [
        "_",
        "_Bool",
        "_Complex",
        "_Imaginery",
        "abstract",
        "alignas",
        "alignof",
        "and",
        "and_eq",
        "any",
        "Any",
        "ArrayNode",
        "array",
        "as",
        "asm",
        "assert",
        "associatedtype",
        "associativity",
        "async",
        "atomic",
        "atomic_cancel",
        "atomic_commit",
        "atomic_noexcept",
        "auto",
        "await",
        "base",
        "bitand",
        "bitor",
        "BOOL",
        "bool",
        "boolean",
        "BooleanNode",
        "break",
        "bycopy",
        "byref",
        "byte",
        "Calendar",
        "case",
        "catch",
        "chan",
        "char",
        "char16_t",
        "char32_t",
        "checked",
        "class",
        "Class",
        "clone",
        "co_await",
        "co_return",
        "co_yield",
        "Codable",
        "CodingKey",
        "CodingKeys",
        "compl",
        "concept",
        "console",
        "const",
        "const_cast",
        "constexpr",
        "constructor",
        "continue",
        "convenience",
        "convert",
        "converter",
        "CultureInfo",
        "date",
        "date_parse_handling",
        "DateFormatter",
        "DateOnly",
        "DateOnlyConverter",
        "DateTime",
        "DateTimeStyles",
        "debugger",
        "decimal",
        "declare",
        "DeserializationFeature",
        "decltype",
        "decode_string",
        "Decoder",
        "DecodingError",
        "def",
        "default",
        "defer",
        "deinit",
        "del",
        "delegate",
        "delete",
        "dict",
        "dictionary",
        "didSet",
        "do",
        "double",
        "DoubleNode",
        "dynamic",
        "dynamic_cast",
        "elif",
        "else",
        "encode_quick_type",
        "Encoder",
        "enum",
        "EnumValues",
        "Equatable",
        "equalityContract",
        "event",
        "except",
        "exception",
        "explicit",
        "export",
        "exposing",
        "extends",
        "extension",
        "extern",
        "fallthrough",
        "false",
        "False",
        "fileprivate",
        "final",
        "finally",
        "fixed",
        "float",
        "for",
        "foreach",
        "FormatException",
        "friend",
        "from",
        "from_dict",
        "from_json",
        "func",
        "function",
        "get",
        "global",
        "go",
        "goto",
        "guard",
        "Hashable",
        "hashCode",
        "Hasher",
        "hasOwnProperty",
        "id",
        "if",
        "IMP",
        "implements",
        "implicit",
        "import",
        "in",
        "indirect",
        "infix",
        "init",
        "inline",
        "inout",
        "instanceof",
        "int",
        "IntNode",
        "interface",
        "internal",
        "IsoDateTimeOffsetConverter",
        "iterable",
        "is",
        "jdec",
        "jenc",
        "jpipe",
        "json",
        "json_converter",
        "json_serializer",
        "json_token",
        "json_writer",
        "JSONAny",
        "JSONCodingKey",
        "JSONDecoder",
        "JSONEncoder",
        "JsonException",
        "JsonGenerator",
        "JsonNode",
        "JSONNull",
        "JsonParser",
        "JsonReader",
        "JsonTokenType",
        "lambda",
        "lazy",
        "left",
        "let",
        "list",
        "LocalDate",
        "LongNode",
        "Locale",
        "lock",
        "long",
        "map",
        "MarshalJSON",
        "MapEntry",
        "metadata_property_handling",
        "module",
        "mutable",
        "mutating",
        "namespace",
        "native",
        "new",
        "newtonsoft",
        "nil",
        "NullNode",
        "NO",
        "noexcept",
        "nonatomic",
        "none",
        "None",
        "nonlocal",
        "nonmutating",
        "NSObject",
        "noSuchMethod",
        "not",
        "not_eq",
        "NSError",
        "NSString",
        "NULL",
        "null",
        "nullptr",
        "number",
        "object",
        "OffsetDateTime",
        "OffsetTime",
        "ObjectNode",
        "ObjectMapper",
        "ObjectReader",
        "ObjectWriter",
        "of",
        "oneway",
        "open",
        "operator",
        "optional",
        "or",
        "or_eq",
        "out",
        "override",
        "package",
        "params",
        "pass",
        "port",
        "postfix",
        "precedence",
        "prefix",
        "print",
        "printf",
        "printMembers",
        "private",
        "protected",
        "Protocol",
        "protocol",
        "public",
        "quicktype",
        "raise",
        "range",
        "readonly",
        "ref",
        "RegExp",
        "register",
        "reinterpret_cast",
        "repeat",
        "require",
        "required",
        "requires",
        "restrict",
        "retain",
        "rethrows",
        "return",
        "right",
        "runtimeType",
        "s",
        "sbyte",
        "sealed",
        "SEL",
        "select",
        "Self",
        "Serializable",
        "self",
        "Sendable",
        "serialize",
        "SerialName",
        "KSerializer",
        "PrimitiveKind",
        "SerialDescriptor",
        "SerializationFeature",
        "SerializerProvider",
        "set",
        "short",
        "signed",
        "SimpleModule",
        "sizeof",
        "stackalloc",
        "Standards",
        "static",
        "static_assert",
        "static_cast",
        "StdDeserializer",
        "StdSerializer",
        "strictfp",
        "string",
        "struct",
        "subscript",
        "super",
        "switch",
        "symbol",
        "synchronized",
        "system",
        "template",
        "then",
        "this",
        "TextNode",
        "thread_local",
        "throw",
        "throws",
        "TimeOnly",
        "TimeOnlyConverter",
        "TimeZone",
        "to_json",
        "top_level",
        "toString",
        "to_dict",
        "transient",
        "True",
        "true",
        "try",
        "Type",
        "type",
        "typealias",
        "typedef",
        "typeid",
        "typename",
        "typeof",
        "uint",
        "ulong",
        "unchecked",
        "undefined",
        "union",
        "UnmarshalJSON",
        "UseSerializers",
        "unowned",
        "unsafe",
        "unsigned",
        "ushort",
        "using",
        "Utf8JsonReader",
        "Utf8JsonWriter",
        "UUID",
        "var",
        "virtual",
        "void",
        "volatile",
        "wchar_t",
        "weak",
        "where",
        "while",
        "willSet",
        "with",
        "xor",
        "xor_eq",
        "YES",
        "yield",
        "dummy",
    ],
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};

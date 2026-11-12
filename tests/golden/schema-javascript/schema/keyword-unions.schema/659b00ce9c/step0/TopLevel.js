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
        { json: "_", js: "_", typ: u(undefined, u(r("Empty"), 3.14)) },
        { json: "_Bool", js: "_Bool", typ: u(undefined, u(r("BoolClass"), 3.14)) },
        { json: "_Complex", js: "_Complex", typ: u(undefined, u(r("Complex"), 3.14)) },
        { json: "_Imaginery", js: "_Imaginery", typ: u(undefined, u(r("Imaginery"), 3.14)) },
        { json: "abstract", js: "abstract", typ: u(undefined, u(r("Abstract"), 3.14)) },
        { json: "alignas", js: "alignas", typ: u(undefined, u(r("Alignas"), 3.14)) },
        { json: "alignof", js: "alignof", typ: u(undefined, u(r("Alignof"), 3.14)) },
        { json: "and", js: "and", typ: u(undefined, u(r("And"), 3.14)) },
        { json: "and_eq", js: "and_eq", typ: u(undefined, u(r("AndEq"), 3.14)) },
        { json: "any", js: "any", typ: u(undefined, u(r("AnyClass"), 3.14)) },
        { json: "Any", js: "Any", typ: u(undefined, u(r("Any"), 3.14)) },
        { json: "array", js: "array", typ: u(undefined, u(r("Array"), 3.14)) },
        { json: "ArrayNode", js: "ArrayNode", typ: u(undefined, u(r("ArrayNode"), 3.14)) },
        { json: "as", js: "as", typ: u(undefined, u(r("As"), 3.14)) },
        { json: "asm", js: "asm", typ: u(undefined, u(r("ASM"), 3.14)) },
        { json: "assert", js: "assert", typ: u(undefined, u(r("Assert"), 3.14)) },
        { json: "associatedtype", js: "associatedtype", typ: u(undefined, u(r("Associatedtype"), 3.14)) },
        { json: "associativity", js: "associativity", typ: u(undefined, u(r("Associativity"), 3.14)) },
        { json: "async", js: "async", typ: u(undefined, u(r("Async"), 3.14)) },
        { json: "atomic", js: "atomic", typ: u(undefined, u(r("Atomic"), 3.14)) },
        { json: "atomic_cancel", js: "atomic_cancel", typ: u(undefined, u(r("AtomicCancel"), 3.14)) },
        { json: "atomic_commit", js: "atomic_commit", typ: u(undefined, u(r("AtomicCommit"), 3.14)) },
        { json: "atomic_noexcept", js: "atomic_noexcept", typ: u(undefined, u(r("AtomicNoexcept"), 3.14)) },
        { json: "auto", js: "auto", typ: u(undefined, u(r("Auto"), 3.14)) },
        { json: "await", js: "await", typ: u(undefined, u(r("Await"), 3.14)) },
        { json: "base", js: "base", typ: u(undefined, u(r("Base"), 3.14)) },
        { json: "bitand", js: "bitand", typ: u(undefined, u(r("Bitand"), 3.14)) },
        { json: "bitor", js: "bitor", typ: u(undefined, u(r("Bitor"), 3.14)) },
        { json: "BOOL", js: "BOOL", typ: u(undefined, u(r("Bool"), 3.14)) },
        { json: "bool", js: "bool", typ: u(undefined, u(r("UnionBoolBool"), 3.14)) },
        { json: "boolean", js: "boolean", typ: u(undefined, u(r("Boolean"), 3.14)) },
        { json: "BooleanNode", js: "BooleanNode", typ: u(undefined, u(r("BooleanNode"), 3.14)) },
        { json: "break", js: "break", typ: u(undefined, u(r("Break"), 3.14)) },
        { json: "bycopy", js: "bycopy", typ: u(undefined, u(r("Bycopy"), 3.14)) },
        { json: "byref", js: "byref", typ: u(undefined, u(r("Byref"), 3.14)) },
        { json: "byte", js: "byte", typ: u(undefined, u(r("Byte"), 3.14)) },
        { json: "Calendar", js: "Calendar", typ: u(undefined, u(r("Calendar"), 3.14)) },
        { json: "case", js: "case", typ: u(undefined, u(r("Case"), 3.14)) },
        { json: "catch", js: "catch", typ: u(undefined, u(r("Catch"), 3.14)) },
        { json: "chan", js: "chan", typ: u(undefined, u(r("Chan"), 3.14)) },
        { json: "char", js: "char", typ: u(undefined, u(r("Char"), 3.14)) },
        { json: "char16_t", js: "char16_t", typ: u(undefined, u(r("Char16T"), 3.14)) },
        { json: "char32_t", js: "char32_t", typ: u(undefined, u(r("Char32T"), 3.14)) },
        { json: "checked", js: "checked", typ: u(undefined, u(r("Checked"), 3.14)) },
        { json: "class", js: "class", typ: u(undefined, u(r("ClassClass"), 3.14)) },
        { json: "Class", js: "Class", typ: u(undefined, u(r("Class"), 3.14)) },
        { json: "clone", js: "clone", typ: u(undefined, u(r("Clone"), 3.14)) },
        { json: "co_await", js: "co_await", typ: u(undefined, u(r("CoAwait"), 3.14)) },
        { json: "co_return", js: "co_return", typ: u(undefined, u(r("CoReturn"), 3.14)) },
        { json: "co_yield", js: "co_yield", typ: u(undefined, u(r("CoYield"), 3.14)) },
        { json: "Codable", js: "Codable", typ: u(undefined, u(r("Codable"), 3.14)) },
        { json: "CodingKey", js: "CodingKey", typ: u(undefined, u(r("CodingKey"), 3.14)) },
        { json: "CodingKeys", js: "CodingKeys", typ: u(undefined, u(r("CodingKeys"), 3.14)) },
        { json: "compl", js: "compl", typ: u(undefined, u(r("Compl"), 3.14)) },
        { json: "concept", js: "concept", typ: u(undefined, u(r("Concept"), 3.14)) },
        { json: "console", js: "console", typ: u(undefined, u(r("Console"), 3.14)) },
        { json: "const", js: "const", typ: u(undefined, u(r("Const"), 3.14)) },
        { json: "const_cast", js: "const_cast", typ: u(undefined, u(r("ConstCast"), 3.14)) },
        { json: "constexpr", js: "constexpr", typ: u(undefined, u(r("Constexpr"), 3.14)) },
        { json: "constructor", js: "constructor", typ: u(undefined, u(r("Constructor"), 3.14)) },
        { json: "continue", js: "continue", typ: u(undefined, u(r("Continue"), 3.14)) },
        { json: "convenience", js: "convenience", typ: u(undefined, u(r("Convenience"), 3.14)) },
        { json: "convert", js: "convert", typ: u(undefined, u(r("Convert"), 3.14)) },
        { json: "converter", js: "converter", typ: u(undefined, u(r("Converter"), 3.14)) },
        { json: "CultureInfo", js: "CultureInfo", typ: u(undefined, u(r("CultureInfo"), 3.14)) },
        { json: "date", js: "date", typ: u(undefined, u(r("Date"), 3.14)) },
        { json: "date_parse_handling", js: "date_parse_handling", typ: u(undefined, u(r("DateParseHandling"), 3.14)) },
        { json: "DateFormatter", js: "DateFormatter", typ: u(undefined, u(r("DateFormatter"), 3.14)) },
        { json: "DateOnly", js: "DateOnly", typ: u(undefined, u(r("DateOnly"), 3.14)) },
        { json: "DateOnlyConverter", js: "DateOnlyConverter", typ: u(undefined, u(r("DateOnlyConverter"), 3.14)) },
        { json: "DateTime", js: "DateTime", typ: u(undefined, u(r("DateTime"), 3.14)) },
        { json: "DateTimeStyles", js: "DateTimeStyles", typ: u(undefined, u(r("DateTimeStyles"), 3.14)) },
        { json: "debugger", js: "debugger", typ: u(undefined, u(r("Debugger"), 3.14)) },
        { json: "decimal", js: "decimal", typ: u(undefined, u(r("Decimal"), 3.14)) },
        { json: "declare", js: "declare", typ: u(undefined, u(r("Declare"), 3.14)) },
        { json: "decltype", js: "decltype", typ: u(undefined, u(r("Decltype"), 3.14)) },
        { json: "decode_string", js: "decode_string", typ: u(undefined, u(r("DecodeString"), 3.14)) },
        { json: "Decoder", js: "Decoder", typ: u(undefined, u(r("Decoder"), 3.14)) },
        { json: "DecodingError", js: "DecodingError", typ: u(undefined, u(r("DecodingError"), 3.14)) },
        { json: "def", js: "def", typ: u(undefined, u(r("Def"), 3.14)) },
        { json: "default", js: "default", typ: u(undefined, u(r("Default"), 3.14)) },
        { json: "defer", js: "defer", typ: u(undefined, u(r("Defer"), 3.14)) },
        { json: "deinit", js: "deinit", typ: u(undefined, u(r("Deinit"), 3.14)) },
        { json: "del", js: "del", typ: u(undefined, u(r("Del"), 3.14)) },
        { json: "delegate", js: "delegate", typ: u(undefined, u(r("Delegate"), 3.14)) },
        { json: "delete", js: "delete", typ: u(undefined, u(r("Delete"), 3.14)) },
        { json: "DeserializationFeature", js: "DeserializationFeature", typ: u(undefined, u(r("DeserializationFeature"), 3.14)) },
        { json: "dict", js: "dict", typ: u(undefined, u(r("Dict"), 3.14)) },
        { json: "dictionary", js: "dictionary", typ: u(undefined, u(r("Dictionary"), 3.14)) },
        { json: "didSet", js: "didSet", typ: u(undefined, u(r("DidSet"), 3.14)) },
        { json: "do", js: "do", typ: u(undefined, u(r("Do"), 3.14)) },
        { json: "double", js: "double", typ: u(undefined, u(r("Double"), 3.14)) },
        { json: "DoubleNode", js: "DoubleNode", typ: u(undefined, u(r("DoubleNode"), 3.14)) },
        { json: "dummy", js: "dummy", typ: u(undefined, 3.14) },
        { json: "dynamic", js: "dynamic", typ: u(undefined, u(r("Dynamic"), 3.14)) },
        { json: "dynamic_cast", js: "dynamic_cast", typ: u(undefined, u(r("DynamicCast"), 3.14)) },
        { json: "elif", js: "elif", typ: u(undefined, u(r("Elif"), 3.14)) },
        { json: "else", js: "else", typ: u(undefined, u(r("Else"), 3.14)) },
        { json: "encode_quick_type", js: "encode_quick_type", typ: u(undefined, u(r("EncodeQuickType"), 3.14)) },
        { json: "Encoder", js: "Encoder", typ: u(undefined, u(r("Encoder"), 3.14)) },
        { json: "enum", js: "enum", typ: u(undefined, u(r("Enum"), 3.14)) },
        { json: "EnumValues", js: "EnumValues", typ: u(undefined, u(r("EnumValues"), 3.14)) },
        { json: "equalityContract", js: "equalityContract", typ: u(undefined, u(r("EqualityContract"), 3.14)) },
        { json: "Equatable", js: "Equatable", typ: u(undefined, u(r("Equatable"), 3.14)) },
        { json: "event", js: "event", typ: u(undefined, u(r("Event"), 3.14)) },
        { json: "except", js: "except", typ: u(undefined, u(r("Except"), 3.14)) },
        { json: "exception", js: "exception", typ: u(undefined, u(r("Exception"), 3.14)) },
        { json: "explicit", js: "explicit", typ: u(undefined, u(r("Explicit"), 3.14)) },
        { json: "export", js: "export", typ: u(undefined, u(r("Export"), 3.14)) },
        { json: "exposing", js: "exposing", typ: u(undefined, u(r("Exposing"), 3.14)) },
        { json: "extends", js: "extends", typ: u(undefined, u(r("Extends"), 3.14)) },
        { json: "extension", js: "extension", typ: u(undefined, u(r("Extension"), 3.14)) },
        { json: "extern", js: "extern", typ: u(undefined, u(r("Extern"), 3.14)) },
        { json: "fallthrough", js: "fallthrough", typ: u(undefined, u(r("Fallthrough"), 3.14)) },
        { json: "false", js: "false", typ: u(undefined, u(r("FalseClass"), 3.14)) },
        { json: "False", js: "False", typ: u(undefined, u(r("False"), 3.14)) },
        { json: "fileprivate", js: "fileprivate", typ: u(undefined, u(r("Fileprivate"), 3.14)) },
        { json: "final", js: "final", typ: u(undefined, u(r("Final"), 3.14)) },
        { json: "finally", js: "finally", typ: u(undefined, u(r("Finally"), 3.14)) },
        { json: "fixed", js: "fixed", typ: u(undefined, u(r("Fixed"), 3.14)) },
        { json: "float", js: "float", typ: u(undefined, u(r("Float"), 3.14)) },
        { json: "for", js: "for", typ: u(undefined, u(r("For"), 3.14)) },
        { json: "foreach", js: "foreach", typ: u(undefined, u(r("Foreach"), 3.14)) },
        { json: "FormatException", js: "FormatException", typ: u(undefined, u(r("FormatException"), 3.14)) },
        { json: "friend", js: "friend", typ: u(undefined, u(r("Friend"), 3.14)) },
        { json: "from", js: "from", typ: u(undefined, u(r("From"), 3.14)) },
        { json: "from_dict", js: "from_dict", typ: u(undefined, u(r("FromDict"), 3.14)) },
        { json: "from_json", js: "from_json", typ: u(undefined, u(r("FromJSON"), 3.14)) },
        { json: "func", js: "func", typ: u(undefined, u(r("Func"), 3.14)) },
        { json: "function", js: "function", typ: u(undefined, u(r("Function"), 3.14)) },
        { json: "get", js: "get", typ: u(undefined, u(r("Get"), 3.14)) },
        { json: "global", js: "global", typ: u(undefined, u(r("Global"), 3.14)) },
        { json: "go", js: "go", typ: u(undefined, u(r("Go"), 3.14)) },
        { json: "goto", js: "goto", typ: u(undefined, u(r("Goto"), 3.14)) },
        { json: "guard", js: "guard", typ: u(undefined, u(r("Guard"), 3.14)) },
        { json: "Hashable", js: "Hashable", typ: u(undefined, u(r("Hashable"), 3.14)) },
        { json: "hashCode", js: "hashCode", typ: u(undefined, u(r("HashCode"), 3.14)) },
        { json: "Hasher", js: "Hasher", typ: u(undefined, u(r("Hasher"), 3.14)) },
        { json: "hasOwnProperty", js: "hasOwnProperty", typ: u(undefined, u(r("HasOwnProperty"), 3.14)) },
        { json: "id", js: "id", typ: u(undefined, u(r("ID"), 3.14)) },
        { json: "if", js: "if", typ: u(undefined, u(r("If"), 3.14)) },
        { json: "IMP", js: "IMP", typ: u(undefined, u(r("Imp"), 3.14)) },
        { json: "implements", js: "implements", typ: u(undefined, u(r("Implements"), 3.14)) },
        { json: "implicit", js: "implicit", typ: u(undefined, u(r("Implicit"), 3.14)) },
        { json: "import", js: "import", typ: u(undefined, u(r("Import"), 3.14)) },
        { json: "in", js: "in", typ: u(undefined, u(r("In"), 3.14)) },
        { json: "indirect", js: "indirect", typ: u(undefined, u(r("Indirect"), 3.14)) },
        { json: "infix", js: "infix", typ: u(undefined, u(r("Infix"), 3.14)) },
        { json: "init", js: "init", typ: u(undefined, u(r("Init"), 3.14)) },
        { json: "inline", js: "inline", typ: u(undefined, u(r("Inline"), 3.14)) },
        { json: "inout", js: "inout", typ: u(undefined, u(r("Inout"), 3.14)) },
        { json: "instanceof", js: "instanceof", typ: u(undefined, u(r("Instanceof"), 3.14)) },
        { json: "int", js: "int", typ: u(undefined, u(r("Int"), 3.14)) },
        { json: "interface", js: "interface", typ: u(undefined, u(r("Interface"), 3.14)) },
        { json: "internal", js: "internal", typ: u(undefined, u(r("Internal"), 3.14)) },
        { json: "IntNode", js: "IntNode", typ: u(undefined, u(r("IntNode"), 3.14)) },
        { json: "is", js: "is", typ: u(undefined, u(r("Is"), 3.14)) },
        { json: "IsoDateTimeOffsetConverter", js: "IsoDateTimeOffsetConverter", typ: u(undefined, u(r("ISODateTimeOffsetConverter"), 3.14)) },
        { json: "iterable", js: "iterable", typ: u(undefined, u(r("Iterable"), 3.14)) },
        { json: "jdec", js: "jdec", typ: u(undefined, u(r("Jdec"), 3.14)) },
        { json: "jenc", js: "jenc", typ: u(undefined, u(r("Jenc"), 3.14)) },
        { json: "jpipe", js: "jpipe", typ: u(undefined, u(r("Jpipe"), 3.14)) },
        { json: "json", js: "json", typ: u(undefined, u(r("JSON"), 3.14)) },
        { json: "json_converter", js: "json_converter", typ: u(undefined, u(r("JSONConverter"), 3.14)) },
        { json: "json_serializer", js: "json_serializer", typ: u(undefined, u(r("JSONSerializer"), 3.14)) },
        { json: "json_token", js: "json_token", typ: u(undefined, u(r("JSONToken"), 3.14)) },
        { json: "json_writer", js: "json_writer", typ: u(undefined, u(r("JSONWriter"), 3.14)) },
        { json: "JSONAny", js: "JSONAny", typ: u(undefined, u(r("JSONAny"), 3.14)) },
        { json: "JSONCodingKey", js: "JSONCodingKey", typ: u(undefined, u(r("JSONCodingKey"), 3.14)) },
        { json: "JSONDecoder", js: "JSONDecoder", typ: u(undefined, u(r("JSONDecoder"), 3.14)) },
        { json: "JSONEncoder", js: "JSONEncoder", typ: u(undefined, u(r("JSONEncoder"), 3.14)) },
        { json: "JsonException", js: "JsonException", typ: u(undefined, u(r("JSONException"), 3.14)) },
        { json: "JsonGenerator", js: "JsonGenerator", typ: u(undefined, u(r("JSONGenerator"), 3.14)) },
        { json: "JsonNode", js: "JsonNode", typ: u(undefined, u(r("JSONNode"), 3.14)) },
        { json: "JSONNull", js: "JSONNull", typ: u(undefined, u(r("JSONNull"), 3.14)) },
        { json: "JsonParser", js: "JsonParser", typ: u(undefined, u(r("JSONParser"), 3.14)) },
        { json: "JsonReader", js: "JsonReader", typ: u(undefined, u(r("JSONReader"), 3.14)) },
        { json: "JsonTokenType", js: "JsonTokenType", typ: u(undefined, u(r("JSONTokenType"), 3.14)) },
        { json: "KSerializer", js: "KSerializer", typ: u(undefined, u(r("KSerializer"), 3.14)) },
        { json: "lambda", js: "lambda", typ: u(undefined, u(r("Lambda"), 3.14)) },
        { json: "lazy", js: "lazy", typ: u(undefined, u(r("Lazy"), 3.14)) },
        { json: "left", js: "left", typ: u(undefined, u(r("Left"), 3.14)) },
        { json: "let", js: "let", typ: u(undefined, u(r("Let"), 3.14)) },
        { json: "list", js: "list", typ: u(undefined, u(r("List"), 3.14)) },
        { json: "LocalDate", js: "LocalDate", typ: u(undefined, u(r("LocalDate"), 3.14)) },
        { json: "Locale", js: "Locale", typ: u(undefined, u(r("Locale"), 3.14)) },
        { json: "lock", js: "lock", typ: u(undefined, u(r("Lock"), 3.14)) },
        { json: "long", js: "long", typ: u(undefined, u(r("Long"), 3.14)) },
        { json: "LongNode", js: "LongNode", typ: u(undefined, u(r("LongNode"), 3.14)) },
        { json: "map", js: "map", typ: u(undefined, u(r("Map"), 3.14)) },
        { json: "MapEntry", js: "MapEntry", typ: u(undefined, u(r("MapEntry"), 3.14)) },
        { json: "MarshalJSON", js: "MarshalJSON", typ: u(undefined, u(r("MarshalJSON"), 3.14)) },
        { json: "metadata_property_handling", js: "metadata_property_handling", typ: u(undefined, u(r("MetadataPropertyHandling"), 3.14)) },
        { json: "module", js: "module", typ: u(undefined, u(r("Module"), 3.14)) },
        { json: "mutable", js: "mutable", typ: u(undefined, u(r("Mutable"), 3.14)) },
        { json: "mutating", js: "mutating", typ: u(undefined, u(r("Mutating"), 3.14)) },
        { json: "namespace", js: "namespace", typ: u(undefined, u(r("Namespace"), 3.14)) },
        { json: "native", js: "native", typ: u(undefined, u(r("Native"), 3.14)) },
        { json: "new", js: "new", typ: u(undefined, u(r("New"), 3.14)) },
        { json: "newtonsoft", js: "newtonsoft", typ: u(undefined, u(r("Newtonsoft"), 3.14)) },
        { json: "nil", js: "nil", typ: u(undefined, u(r("Nil"), 3.14)) },
        { json: "NO", js: "NO", typ: u(undefined, u(r("No"), 3.14)) },
        { json: "noexcept", js: "noexcept", typ: u(undefined, u(r("Noexcept"), 3.14)) },
        { json: "nonatomic", js: "nonatomic", typ: u(undefined, u(r("Nonatomic"), 3.14)) },
        { json: "none", js: "none", typ: u(undefined, u(r("NoneClass"), 3.14)) },
        { json: "None", js: "None", typ: u(undefined, u(r("None"), 3.14)) },
        { json: "nonlocal", js: "nonlocal", typ: u(undefined, u(r("Nonlocal"), 3.14)) },
        { json: "nonmutating", js: "nonmutating", typ: u(undefined, u(r("Nonmutating"), 3.14)) },
        { json: "noSuchMethod", js: "noSuchMethod", typ: u(undefined, u(r("NoSuchMethod"), 3.14)) },
        { json: "not", js: "not", typ: u(undefined, u(r("Not"), 3.14)) },
        { json: "not_eq", js: "not_eq", typ: u(undefined, u(r("NotEq"), 3.14)) },
        { json: "NSError", js: "NSError", typ: u(undefined, u(r("NSError"), 3.14)) },
        { json: "NSObject", js: "NSObject", typ: u(undefined, u(r("NSObject"), 3.14)) },
        { json: "NSString", js: "NSString", typ: u(undefined, u(r("NSString"), 3.14)) },
        { json: "NULL", js: "NULL", typ: u(undefined, u(r("Null"), 3.14)) },
        { json: "null", js: "null", typ: u(undefined, u(r("NullClass"), 3.14)) },
        { json: "NullNode", js: "NullNode", typ: u(undefined, u(r("NullNode"), 3.14)) },
        { json: "nullptr", js: "nullptr", typ: u(undefined, u(r("Nullptr"), 3.14)) },
        { json: "number", js: "number", typ: u(undefined, u(r("Number"), 3.14)) },
        { json: "object", js: "object", typ: u(undefined, u(r("Object"), 3.14)) },
        { json: "ObjectMapper", js: "ObjectMapper", typ: u(undefined, u(r("ObjectMapper"), 3.14)) },
        { json: "ObjectNode", js: "ObjectNode", typ: u(undefined, u(r("ObjectNode"), 3.14)) },
        { json: "ObjectReader", js: "ObjectReader", typ: u(undefined, u(r("ObjectReader"), 3.14)) },
        { json: "ObjectWriter", js: "ObjectWriter", typ: u(undefined, u(r("ObjectWriter"), 3.14)) },
        { json: "of", js: "of", typ: u(undefined, u(r("Of"), 3.14)) },
        { json: "OffsetDateTime", js: "OffsetDateTime", typ: u(undefined, u(r("OffsetDateTime"), 3.14)) },
        { json: "OffsetTime", js: "OffsetTime", typ: u(undefined, u(r("OffsetTime"), 3.14)) },
        { json: "oneway", js: "oneway", typ: u(undefined, u(r("Oneway"), 3.14)) },
        { json: "open", js: "open", typ: u(undefined, u(r("Open"), 3.14)) },
        { json: "operator", js: "operator", typ: u(undefined, u(r("Operator"), 3.14)) },
        { json: "optional", js: "optional", typ: u(undefined, u(r("Optional"), 3.14)) },
        { json: "or", js: "or", typ: u(undefined, u(r("Or"), 3.14)) },
        { json: "or_eq", js: "or_eq", typ: u(undefined, u(r("OrEq"), 3.14)) },
        { json: "out", js: "out", typ: u(undefined, u(r("Out"), 3.14)) },
        { json: "override", js: "override", typ: u(undefined, u(r("Override"), 3.14)) },
        { json: "package", js: "package", typ: u(undefined, u(r("Package"), 3.14)) },
        { json: "params", js: "params", typ: u(undefined, u(r("Params"), 3.14)) },
        { json: "pass", js: "pass", typ: u(undefined, u(r("Pass"), 3.14)) },
        { json: "port", js: "port", typ: u(undefined, u(r("Port"), 3.14)) },
        { json: "postfix", js: "postfix", typ: u(undefined, u(r("Postfix"), 3.14)) },
        { json: "precedence", js: "precedence", typ: u(undefined, u(r("Precedence"), 3.14)) },
        { json: "prefix", js: "prefix", typ: u(undefined, u(r("Prefix"), 3.14)) },
        { json: "PrimitiveKind", js: "PrimitiveKind", typ: u(undefined, u(r("PrimitiveKind"), 3.14)) },
        { json: "print", js: "print", typ: u(undefined, u(r("Print"), 3.14)) },
        { json: "printf", js: "printf", typ: u(undefined, u(r("Printf"), 3.14)) },
        { json: "printMembers", js: "printMembers", typ: u(undefined, u(r("PrintMembers"), 3.14)) },
        { json: "private", js: "private", typ: u(undefined, u(r("Private"), 3.14)) },
        { json: "protected", js: "protected", typ: u(undefined, u(r("Protected"), 3.14)) },
        { json: "Protocol", js: "Protocol", typ: u(undefined, u(r("Protocol"), 3.14)) },
        { json: "protocol", js: "protocol", typ: u(undefined, u(r("ProtocolClass"), 3.14)) },
        { json: "public", js: "public", typ: u(undefined, u(r("Public"), 3.14)) },
        { json: "quicktype", js: "quicktype", typ: u(undefined, u(r("Quicktype"), 3.14)) },
        { json: "raise", js: "raise", typ: u(undefined, u(r("Raise"), 3.14)) },
        { json: "range", js: "range", typ: u(undefined, u(r("Range"), 3.14)) },
        { json: "readonly", js: "readonly", typ: u(undefined, u(r("Readonly"), 3.14)) },
        { json: "ref", js: "ref", typ: u(undefined, u(r("Ref"), 3.14)) },
        { json: "RegExp", js: "RegExp", typ: u(undefined, u(r("RegExp"), 3.14)) },
        { json: "register", js: "register", typ: u(undefined, u(r("Register"), 3.14)) },
        { json: "reinterpret_cast", js: "reinterpret_cast", typ: u(undefined, u(r("ReinterpretCast"), 3.14)) },
        { json: "repeat", js: "repeat", typ: u(undefined, u(r("Repeat"), 3.14)) },
        { json: "require", js: "require", typ: u(undefined, u(r("Require"), 3.14)) },
        { json: "required", js: "required", typ: u(undefined, u(r("Required"), 3.14)) },
        { json: "requires", js: "requires", typ: u(undefined, u(r("Requires"), 3.14)) },
        { json: "restrict", js: "restrict", typ: u(undefined, u(r("Restrict"), 3.14)) },
        { json: "retain", js: "retain", typ: u(undefined, u(r("Retain"), 3.14)) },
        { json: "rethrows", js: "rethrows", typ: u(undefined, u(r("Rethrows"), 3.14)) },
        { json: "return", js: "return", typ: u(undefined, u(r("Return"), 3.14)) },
        { json: "right", js: "right", typ: u(undefined, u(r("Right"), 3.14)) },
        { json: "runtimeType", js: "runtimeType", typ: u(undefined, u(r("RuntimeType"), 3.14)) },
        { json: "s", js: "s", typ: u(undefined, u(r("S"), 3.14)) },
        { json: "sbyte", js: "sbyte", typ: u(undefined, u(r("Sbyte"), 3.14)) },
        { json: "sealed", js: "sealed", typ: u(undefined, u(r("Sealed"), 3.14)) },
        { json: "SEL", js: "SEL", typ: u(undefined, u(r("Sel"), 3.14)) },
        { json: "select", js: "select", typ: u(undefined, u(r("Select"), 3.14)) },
        { json: "Self", js: "Self", typ: u(undefined, u(r("Self"), 3.14)) },
        { json: "self", js: "self", typ: u(undefined, u(r("SelfClass"), 3.14)) },
        { json: "Sendable", js: "Sendable", typ: u(undefined, u(r("Sendable"), 3.14)) },
        { json: "SerialDescriptor", js: "SerialDescriptor", typ: u(undefined, u(r("SerialDescriptor"), 3.14)) },
        { json: "Serializable", js: "Serializable", typ: u(undefined, u(r("Serializable"), 3.14)) },
        { json: "SerializationFeature", js: "SerializationFeature", typ: u(undefined, u(r("SerializationFeature"), 3.14)) },
        { json: "serialize", js: "serialize", typ: u(undefined, u(r("Serialize"), 3.14)) },
        { json: "SerializerProvider", js: "SerializerProvider", typ: u(undefined, u(r("SerializerProvider"), 3.14)) },
        { json: "SerialName", js: "SerialName", typ: u(undefined, u(r("SerialName"), 3.14)) },
        { json: "set", js: "set", typ: u(undefined, u(r("Set"), 3.14)) },
        { json: "short", js: "short", typ: u(undefined, u(r("Short"), 3.14)) },
        { json: "signed", js: "signed", typ: u(undefined, u(r("Signed"), 3.14)) },
        { json: "SimpleModule", js: "SimpleModule", typ: u(undefined, u(r("SimpleModule"), 3.14)) },
        { json: "sizeof", js: "sizeof", typ: u(undefined, u(r("Sizeof"), 3.14)) },
        { json: "stackalloc", js: "stackalloc", typ: u(undefined, u(r("Stackalloc"), 3.14)) },
        { json: "Standards", js: "Standards", typ: u(undefined, u(r("Standards"), 3.14)) },
        { json: "static", js: "static", typ: u(undefined, u(r("Static"), 3.14)) },
        { json: "static_assert", js: "static_assert", typ: u(undefined, u(r("StaticAssert"), 3.14)) },
        { json: "static_cast", js: "static_cast", typ: u(undefined, u(r("StaticCast"), 3.14)) },
        { json: "StdDeserializer", js: "StdDeserializer", typ: u(undefined, u(r("StdDeserializer"), 3.14)) },
        { json: "StdSerializer", js: "StdSerializer", typ: u(undefined, u(r("StdSerializer"), 3.14)) },
        { json: "strictfp", js: "strictfp", typ: u(undefined, u(r("Strictfp"), 3.14)) },
        { json: "string", js: "string", typ: u(undefined, u(r("String"), 3.14)) },
        { json: "struct", js: "struct", typ: u(undefined, u(r("Struct"), 3.14)) },
        { json: "subscript", js: "subscript", typ: u(undefined, u(r("Subscript"), 3.14)) },
        { json: "super", js: "super", typ: u(undefined, u(r("Super"), 3.14)) },
        { json: "switch", js: "switch", typ: u(undefined, u(r("Switch"), 3.14)) },
        { json: "symbol", js: "symbol", typ: u(undefined, u(r("Symbol"), 3.14)) },
        { json: "synchronized", js: "synchronized", typ: u(undefined, u(r("Synchronized"), 3.14)) },
        { json: "system", js: "system", typ: u(undefined, u(r("System"), 3.14)) },
        { json: "template", js: "template", typ: u(undefined, u(r("Template"), 3.14)) },
        { json: "TextNode", js: "TextNode", typ: u(undefined, u(r("TextNode"), 3.14)) },
        { json: "then", js: "then", typ: u(undefined, u(r("Then"), 3.14)) },
        { json: "this", js: "this", typ: u(undefined, u(r("This"), 3.14)) },
        { json: "thread_local", js: "thread_local", typ: u(undefined, u(r("ThreadLocal"), 3.14)) },
        { json: "throw", js: "throw", typ: u(undefined, u(r("Throw"), 3.14)) },
        { json: "throws", js: "throws", typ: u(undefined, u(r("Throws"), 3.14)) },
        { json: "TimeOnly", js: "TimeOnly", typ: u(undefined, u(r("TimeOnly"), 3.14)) },
        { json: "TimeOnlyConverter", js: "TimeOnlyConverter", typ: u(undefined, u(r("TimeOnlyConverter"), 3.14)) },
        { json: "TimeZone", js: "TimeZone", typ: u(undefined, u(r("TimeZone"), 3.14)) },
        { json: "to_dict", js: "to_dict", typ: u(undefined, u(r("ToDict"), 3.14)) },
        { json: "to_json", js: "to_json", typ: u(undefined, u(r("ToJSON"), 3.14)) },
        { json: "top_level", js: "top_level", typ: u(undefined, u(r("TopLevelClass"), 3.14)) },
        { json: "toString", js: "toString", typ: u(undefined, u(r("ToString"), 3.14)) },
        { json: "transient", js: "transient", typ: u(undefined, u(r("Transient"), 3.14)) },
        { json: "True", js: "True", typ: u(undefined, u(r("True"), 3.14)) },
        { json: "true", js: "true", typ: u(undefined, u(r("TrueClass"), 3.14)) },
        { json: "try", js: "try", typ: u(undefined, u(r("Try"), 3.14)) },
        { json: "Type", js: "Type", typ: u(undefined, u(r("Type"), 3.14)) },
        { json: "type", js: "type", typ: u(undefined, u(r("TypeClass"), 3.14)) },
        { json: "typealias", js: "typealias", typ: u(undefined, u(r("Typealias"), 3.14)) },
        { json: "typedef", js: "typedef", typ: u(undefined, u(r("Typedef"), 3.14)) },
        { json: "typeid", js: "typeid", typ: u(undefined, u(r("Typeid"), 3.14)) },
        { json: "typename", js: "typename", typ: u(undefined, u(r("Typename"), 3.14)) },
        { json: "typeof", js: "typeof", typ: u(undefined, u(r("Typeof"), 3.14)) },
        { json: "uint", js: "uint", typ: u(undefined, u(r("Uint"), 3.14)) },
        { json: "ulong", js: "ulong", typ: u(undefined, u(r("Ulong"), 3.14)) },
        { json: "unchecked", js: "unchecked", typ: u(undefined, u(r("Unchecked"), 3.14)) },
        { json: "undefined", js: "undefined", typ: u(undefined, u(r("Undefined"), 3.14)) },
        { json: "union", js: "union", typ: u(undefined, u(r("Union"), 3.14)) },
        { json: "UnmarshalJSON", js: "UnmarshalJSON", typ: u(undefined, u(r("UnmarshalJSON"), 3.14)) },
        { json: "unowned", js: "unowned", typ: u(undefined, u(r("Unowned"), 3.14)) },
        { json: "unsafe", js: "unsafe", typ: u(undefined, u(r("Unsafe"), 3.14)) },
        { json: "unsigned", js: "unsigned", typ: u(undefined, u(r("Unsigned"), 3.14)) },
        { json: "UseSerializers", js: "UseSerializers", typ: u(undefined, u(r("UseSerializers"), 3.14)) },
        { json: "ushort", js: "ushort", typ: u(undefined, u(r("Ushort"), 3.14)) },
        { json: "using", js: "using", typ: u(undefined, u(r("Using"), 3.14)) },
        { json: "Utf8JsonReader", js: "Utf8JsonReader", typ: u(undefined, u(r("Utf8JSONReader"), 3.14)) },
        { json: "Utf8JsonWriter", js: "Utf8JsonWriter", typ: u(undefined, u(r("Utf8JSONWriter"), 3.14)) },
        { json: "UUID", js: "UUID", typ: u(undefined, u(r("UUID"), 3.14)) },
        { json: "var", js: "var", typ: u(undefined, u(r("Var"), 3.14)) },
        { json: "virtual", js: "virtual", typ: u(undefined, u(r("Virtual"), 3.14)) },
        { json: "void", js: "void", typ: u(undefined, u(r("Void"), 3.14)) },
        { json: "volatile", js: "volatile", typ: u(undefined, u(r("Volatile"), 3.14)) },
        { json: "wchar_t", js: "wchar_t", typ: u(undefined, u(r("WcharT"), 3.14)) },
        { json: "weak", js: "weak", typ: u(undefined, u(r("Weak"), 3.14)) },
        { json: "where", js: "where", typ: u(undefined, u(r("Where"), 3.14)) },
        { json: "while", js: "while", typ: u(undefined, u(r("While"), 3.14)) },
        { json: "willSet", js: "willSet", typ: u(undefined, u(r("WillSet"), 3.14)) },
        { json: "with", js: "with", typ: u(undefined, u(r("With"), 3.14)) },
        { json: "xor", js: "xor", typ: u(undefined, u(r("Xor"), 3.14)) },
        { json: "xor_eq", js: "xor_eq", typ: u(undefined, u(r("XorEq"), 3.14)) },
        { json: "YES", js: "YES", typ: u(undefined, u(r("Yes"), 3.14)) },
        { json: "yield", js: "yield", typ: u(undefined, u(r("Yield"), 3.14)) },
    ], "any"),
    "Any": o([
    ], false),
    "ArrayNode": o([
    ], false),
    "Bool": o([
    ], false),
    "BooleanNode": o([
    ], false),
    "Calendar": o([
    ], false),
    "Class": o([
    ], false),
    "Codable": o([
    ], false),
    "CodingKey": o([
    ], false),
    "CodingKeys": o([
    ], false),
    "CultureInfo": o([
    ], false),
    "DateFormatter": o([
    ], false),
    "DateOnly": o([
    ], false),
    "DateOnlyConverter": o([
    ], false),
    "DateTime": o([
    ], false),
    "DateTimeStyles": o([
    ], false),
    "Decoder": o([
    ], false),
    "DecodingError": o([
    ], false),
    "DeserializationFeature": o([
    ], false),
    "DoubleNode": o([
    ], false),
    "Encoder": o([
    ], false),
    "EnumValues": o([
    ], false),
    "Equatable": o([
    ], false),
    "False": o([
    ], false),
    "FormatException": o([
    ], false),
    "Hashable": o([
    ], false),
    "Hasher": o([
    ], false),
    "Imp": o([
    ], false),
    "IntNode": o([
    ], false),
    "ISODateTimeOffsetConverter": o([
    ], false),
    "JSONAny": o([
    ], false),
    "JSONCodingKey": o([
    ], false),
    "JSONDecoder": o([
    ], false),
    "JSONEncoder": o([
    ], false),
    "JSONNull": o([
    ], false),
    "JSONException": o([
    ], false),
    "JSONGenerator": o([
    ], false),
    "JSONNode": o([
    ], false),
    "JSONParser": o([
    ], false),
    "JSONReader": o([
    ], false),
    "JSONTokenType": o([
    ], false),
    "KSerializer": o([
    ], false),
    "LocalDate": o([
    ], false),
    "Locale": o([
    ], false),
    "LongNode": o([
    ], false),
    "MapEntry": o([
    ], false),
    "MarshalJSON": o([
    ], false),
    "No": o([
    ], false),
    "NSError": o([
    ], false),
    "NSObject": o([
    ], false),
    "NSString": o([
    ], false),
    "Null": o([
    ], false),
    "None": o([
    ], false),
    "NullNode": o([
    ], false),
    "ObjectMapper": o([
    ], false),
    "ObjectNode": o([
    ], false),
    "ObjectReader": o([
    ], false),
    "ObjectWriter": o([
    ], false),
    "OffsetDateTime": o([
    ], false),
    "OffsetTime": o([
    ], false),
    "PrimitiveKind": o([
    ], false),
    "Protocol": o([
    ], false),
    "RegExp": o([
    ], false),
    "Sel": o([
    ], false),
    "Self": o([
    ], false),
    "Sendable": o([
    ], false),
    "SerialDescriptor": o([
    ], false),
    "SerialName": o([
    ], false),
    "Serializable": o([
    ], false),
    "SerializationFeature": o([
    ], false),
    "SerializerProvider": o([
    ], false),
    "SimpleModule": o([
    ], false),
    "Standards": o([
    ], false),
    "StdDeserializer": o([
    ], false),
    "StdSerializer": o([
    ], false),
    "TextNode": o([
    ], false),
    "TimeOnly": o([
    ], false),
    "TimeOnlyConverter": o([
    ], false),
    "TimeZone": o([
    ], false),
    "True": o([
    ], false),
    "Type": o([
    ], false),
    "UUID": o([
    ], false),
    "UnmarshalJSON": o([
    ], false),
    "UseSerializers": o([
    ], false),
    "Utf8JSONReader": o([
    ], false),
    "Utf8JSONWriter": o([
    ], false),
    "Yes": o([
    ], false),
    "Empty": o([
    ], false),
    "BoolClass": o([
    ], false),
    "Complex": o([
    ], false),
    "Imaginery": o([
    ], false),
    "Abstract": o([
    ], false),
    "Alignas": o([
    ], false),
    "Alignof": o([
    ], false),
    "And": o([
    ], false),
    "AndEq": o([
    ], false),
    "AnyClass": o([
    ], false),
    "Array": o([
    ], false),
    "As": o([
    ], false),
    "ASM": o([
    ], false),
    "Assert": o([
    ], false),
    "Associatedtype": o([
    ], false),
    "Associativity": o([
    ], false),
    "Async": o([
    ], false),
    "Atomic": o([
    ], false),
    "AtomicCancel": o([
    ], false),
    "AtomicCommit": o([
    ], false),
    "AtomicNoexcept": o([
    ], false),
    "Auto": o([
    ], false),
    "Await": o([
    ], false),
    "Base": o([
    ], false),
    "Bitand": o([
    ], false),
    "Bitor": o([
    ], false),
    "UnionBoolBool": o([
    ], false),
    "Boolean": o([
    ], false),
    "Break": o([
    ], false),
    "Bycopy": o([
    ], false),
    "Byref": o([
    ], false),
    "Byte": o([
    ], false),
    "Case": o([
    ], false),
    "Catch": o([
    ], false),
    "Chan": o([
    ], false),
    "Char": o([
    ], false),
    "Char16T": o([
    ], false),
    "Char32T": o([
    ], false),
    "Checked": o([
    ], false),
    "ClassClass": o([
    ], false),
    "Clone": o([
    ], false),
    "CoAwait": o([
    ], false),
    "CoReturn": o([
    ], false),
    "CoYield": o([
    ], false),
    "Compl": o([
    ], false),
    "Concept": o([
    ], false),
    "Console": o([
    ], false),
    "Const": o([
    ], false),
    "ConstCast": o([
    ], false),
    "Constexpr": o([
    ], false),
    "Constructor": o([
    ], false),
    "Continue": o([
    ], false),
    "Convenience": o([
    ], false),
    "Convert": o([
    ], false),
    "Converter": o([
    ], false),
    "Date": o([
    ], false),
    "DateParseHandling": o([
    ], false),
    "Debugger": o([
    ], false),
    "Decimal": o([
    ], false),
    "Declare": o([
    ], false),
    "Decltype": o([
    ], false),
    "DecodeString": o([
    ], false),
    "Def": o([
    ], false),
    "Default": o([
    ], false),
    "Defer": o([
    ], false),
    "Deinit": o([
    ], false),
    "Del": o([
    ], false),
    "Delegate": o([
    ], false),
    "Delete": o([
    ], false),
    "Dict": o([
    ], false),
    "Dictionary": o([
    ], false),
    "DidSet": o([
    ], false),
    "Do": o([
    ], false),
    "Double": o([
    ], false),
    "Dynamic": o([
    ], false),
    "DynamicCast": o([
    ], false),
    "Elif": o([
    ], false),
    "Else": o([
    ], false),
    "EncodeQuickType": o([
    ], false),
    "Enum": o([
    ], false),
    "EqualityContract": o([
    ], false),
    "Event": o([
    ], false),
    "Except": o([
    ], false),
    "Exception": o([
    ], false),
    "Explicit": o([
    ], false),
    "Export": o([
    ], false),
    "Exposing": o([
    ], false),
    "Extends": o([
    ], false),
    "Extension": o([
    ], false),
    "Extern": o([
    ], false),
    "Fallthrough": o([
    ], false),
    "FalseClass": o([
    ], false),
    "Fileprivate": o([
    ], false),
    "Final": o([
    ], false),
    "Finally": o([
    ], false),
    "Fixed": o([
    ], false),
    "Float": o([
    ], false),
    "For": o([
    ], false),
    "Foreach": o([
    ], false),
    "Friend": o([
    ], false),
    "From": o([
    ], false),
    "FromDict": o([
    ], false),
    "FromJSON": o([
    ], false),
    "Func": o([
    ], false),
    "Function": o([
    ], false),
    "Get": o([
    ], false),
    "Global": o([
    ], false),
    "Go": o([
    ], false),
    "Goto": o([
    ], false),
    "Guard": o([
    ], false),
    "HasOwnProperty": o([
    ], false),
    "HashCode": o([
    ], false),
    "ID": o([
    ], false),
    "If": o([
    ], false),
    "Implements": o([
    ], false),
    "Implicit": o([
    ], false),
    "Import": o([
    ], false),
    "In": o([
    ], false),
    "Indirect": o([
    ], false),
    "Infix": o([
    ], false),
    "Init": o([
    ], false),
    "Inline": o([
    ], false),
    "Inout": o([
    ], false),
    "Instanceof": o([
    ], false),
    "Int": o([
    ], false),
    "Interface": o([
    ], false),
    "Internal": o([
    ], false),
    "Is": o([
    ], false),
    "Iterable": o([
    ], false),
    "Jdec": o([
    ], false),
    "Jenc": o([
    ], false),
    "Jpipe": o([
    ], false),
    "JSON": o([
    ], false),
    "JSONConverter": o([
    ], false),
    "JSONSerializer": o([
    ], false),
    "JSONToken": o([
    ], false),
    "JSONWriter": o([
    ], false),
    "Lambda": o([
    ], false),
    "Lazy": o([
    ], false),
    "Left": o([
    ], false),
    "Let": o([
    ], false),
    "List": o([
    ], false),
    "Lock": o([
    ], false),
    "Long": o([
    ], false),
    "Map": o([
    ], false),
    "MetadataPropertyHandling": o([
    ], false),
    "Module": o([
    ], false),
    "Mutable": o([
    ], false),
    "Mutating": o([
    ], false),
    "Namespace": o([
    ], false),
    "Native": o([
    ], false),
    "New": o([
    ], false),
    "Newtonsoft": o([
    ], false),
    "Nil": o([
    ], false),
    "NoSuchMethod": o([
    ], false),
    "Noexcept": o([
    ], false),
    "Nonatomic": o([
    ], false),
    "NoneClass": o([
    ], false),
    "Nonlocal": o([
    ], false),
    "Nonmutating": o([
    ], false),
    "Not": o([
    ], false),
    "NotEq": o([
    ], false),
    "NullClass": o([
    ], false),
    "Nullptr": o([
    ], false),
    "Number": o([
    ], false),
    "Object": o([
    ], false),
    "Of": o([
    ], false),
    "Oneway": o([
    ], false),
    "Open": o([
    ], false),
    "Operator": o([
    ], false),
    "Optional": o([
    ], false),
    "Or": o([
    ], false),
    "OrEq": o([
    ], false),
    "Out": o([
    ], false),
    "Override": o([
    ], false),
    "Package": o([
    ], false),
    "Params": o([
    ], false),
    "Pass": o([
    ], false),
    "Port": o([
    ], false),
    "Postfix": o([
    ], false),
    "Precedence": o([
    ], false),
    "Prefix": o([
    ], false),
    "Print": o([
    ], false),
    "PrintMembers": o([
    ], false),
    "Printf": o([
    ], false),
    "Private": o([
    ], false),
    "Protected": o([
    ], false),
    "ProtocolClass": o([
    ], false),
    "Public": o([
    ], false),
    "Quicktype": o([
    ], false),
    "Raise": o([
    ], false),
    "Range": o([
    ], false),
    "Readonly": o([
    ], false),
    "Ref": o([
    ], false),
    "Register": o([
    ], false),
    "ReinterpretCast": o([
    ], false),
    "Repeat": o([
    ], false),
    "Require": o([
    ], false),
    "Required": o([
    ], false),
    "Requires": o([
    ], false),
    "Restrict": o([
    ], false),
    "Retain": o([
    ], false),
    "Rethrows": o([
    ], false),
    "Return": o([
    ], false),
    "Right": o([
    ], false),
    "RuntimeType": o([
    ], false),
    "S": o([
    ], false),
    "Sbyte": o([
    ], false),
    "Sealed": o([
    ], false),
    "Select": o([
    ], false),
    "SelfClass": o([
    ], false),
    "Serialize": o([
    ], false),
    "Set": o([
    ], false),
    "Short": o([
    ], false),
    "Signed": o([
    ], false),
    "Sizeof": o([
    ], false),
    "Stackalloc": o([
    ], false),
    "Static": o([
    ], false),
    "StaticAssert": o([
    ], false),
    "StaticCast": o([
    ], false),
    "Strictfp": o([
    ], false),
    "String": o([
    ], false),
    "Struct": o([
    ], false),
    "Subscript": o([
    ], false),
    "Super": o([
    ], false),
    "Switch": o([
    ], false),
    "Symbol": o([
    ], false),
    "Synchronized": o([
    ], false),
    "System": o([
    ], false),
    "Template": o([
    ], false),
    "Then": o([
    ], false),
    "This": o([
    ], false),
    "ThreadLocal": o([
    ], false),
    "Throw": o([
    ], false),
    "Throws": o([
    ], false),
    "ToString": o([
    ], false),
    "ToDict": o([
    ], false),
    "ToJSON": o([
    ], false),
    "TopLevelClass": o([
    ], false),
    "Transient": o([
    ], false),
    "TrueClass": o([
    ], false),
    "Try": o([
    ], false),
    "TypeClass": o([
    ], false),
    "Typealias": o([
    ], false),
    "Typedef": o([
    ], false),
    "Typeid": o([
    ], false),
    "Typename": o([
    ], false),
    "Typeof": o([
    ], false),
    "Uint": o([
    ], false),
    "Ulong": o([
    ], false),
    "Unchecked": o([
    ], false),
    "Undefined": o([
    ], false),
    "Union": o([
    ], false),
    "Unowned": o([
    ], false),
    "Unsafe": o([
    ], false),
    "Unsigned": o([
    ], false),
    "Ushort": o([
    ], false),
    "Using": o([
    ], false),
    "Var": o([
    ], false),
    "Virtual": o([
    ], false),
    "Void": o([
    ], false),
    "Volatile": o([
    ], false),
    "WcharT": o([
    ], false),
    "Weak": o([
    ], false),
    "Where": o([
    ], false),
    "While": o([
    ], false),
    "WillSet": o([
    ], false),
    "With": o([
    ], false),
    "Xor": o([
    ], false),
    "XorEq": o([
    ], false),
    "Yield": o([
    ], false),
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};

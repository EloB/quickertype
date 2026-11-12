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
        return typ.hasOwnProperty("uuid")         ? typeof val === "string" && /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(val) ? val : invalidValue(typ, val, key, parent)
            : typ.hasOwnProperty("pattern")      ? typeof val === "string" && new RegExp(typ.pattern).test(val) ? val : invalidValue(typ, val, key, parent)
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
        { json: "dummy", js: "dummy", typ: i(0) },
        { json: "obj1", js: "obj1", typ: r("Obj1") },
        { json: "obj2", js: "obj2", typ: r("Obj2") },
        { json: "obj3", js: "obj3", typ: r("Obj3") },
        { json: "obj4", js: "obj4", typ: r("Obj4") },
        { json: "obj5", js: "obj5", typ: r("Obj5") },
        { json: "obj6", js: "obj6", typ: r("Obj6") },
    ], false),
    "Obj1": o([
        { json: "Any", js: "Any", typ: r("Any") },
        { json: "ArrayNode", js: "ArrayNode", typ: r("ArrayNode") },
        { json: "BOOL", js: "BOOL", typ: r("Bool") },
        { json: "BooleanNode", js: "BooleanNode", typ: r("BooleanNode") },
        { json: "Calendar", js: "Calendar", typ: r("Calendar") },
        { json: "Class", js: "Class", typ: r("Class") },
        { json: "Codable", js: "Codable", typ: r("Codable") },
        { json: "CodingKey", js: "CodingKey", typ: r("CodingKey") },
        { json: "CodingKeys", js: "CodingKeys", typ: r("CodingKeys") },
        { json: "_", js: "_", typ: r("Empty") },
        { json: "_Bool", js: "_Bool", typ: r("BoolClass") },
        { json: "_Complex", js: "_Complex", typ: r("Complex") },
        { json: "_Imaginery", js: "_Imaginery", typ: r("Imaginery") },
        { json: "abstract", js: "abstract", typ: r("Abstract") },
        { json: "alignas", js: "alignas", typ: r("Alignas") },
        { json: "alignof", js: "alignof", typ: r("Alignof") },
        { json: "and", js: "and", typ: r("And") },
        { json: "and_eq", js: "and_eq", typ: r("AndEq") },
        { json: "any", js: "any", typ: r("AnyClass") },
        { json: "array", js: "array", typ: r("Array") },
        { json: "as", js: "as", typ: r("As") },
        { json: "asm", js: "asm", typ: r("ASM") },
        { json: "assert", js: "assert", typ: r("Assert") },
        { json: "associatedtype", js: "associatedtype", typ: r("Associatedtype") },
        { json: "associativity", js: "associativity", typ: r("Associativity") },
        { json: "async", js: "async", typ: r("Async") },
        { json: "atomic", js: "atomic", typ: r("Atomic") },
        { json: "atomic_cancel", js: "atomic_cancel", typ: r("AtomicCancel") },
        { json: "atomic_commit", js: "atomic_commit", typ: r("AtomicCommit") },
        { json: "atomic_noexcept", js: "atomic_noexcept", typ: r("AtomicNoexcept") },
        { json: "auto", js: "auto", typ: r("Auto") },
        { json: "await", js: "await", typ: r("Await") },
        { json: "base", js: "base", typ: r("Base") },
        { json: "bitand", js: "bitand", typ: r("Bitand") },
        { json: "bitor", js: "bitor", typ: r("Bitor") },
        { json: "bool", js: "bool", typ: r("Obj1Bool") },
        { json: "boolean", js: "boolean", typ: r("Boolean") },
        { json: "break", js: "break", typ: r("Break") },
        { json: "bycopy", js: "bycopy", typ: r("Bycopy") },
        { json: "byref", js: "byref", typ: r("Byref") },
        { json: "byte", js: "byte", typ: r("Byte") },
        { json: "case", js: "case", typ: r("Case") },
        { json: "catch", js: "catch", typ: r("Catch") },
        { json: "chan", js: "chan", typ: r("Chan") },
        { json: "char", js: "char", typ: r("Char") },
        { json: "char16_t", js: "char16_t", typ: r("Char16T") },
        { json: "char32_t", js: "char32_t", typ: r("Char32T") },
        { json: "checked", js: "checked", typ: r("Checked") },
        { json: "class", js: "class", typ: r("ClassClass") },
        { json: "clone", js: "clone", typ: r("Clone") },
        { json: "co_await", js: "co_await", typ: r("CoAwait") },
        { json: "co_return", js: "co_return", typ: r("CoReturn") },
        { json: "co_yield", js: "co_yield", typ: r("CoYield") },
        { json: "compl", js: "compl", typ: r("Compl") },
        { json: "concept", js: "concept", typ: r("Concept") },
        { json: "console", js: "console", typ: r("Console") },
        { json: "const", js: "const", typ: r("Const") },
        { json: "const_cast", js: "const_cast", typ: r("ConstCast") },
        { json: "constexpr", js: "constexpr", typ: r("Constexpr") },
        { json: "constructor", js: "constructor", typ: r("Constructor") },
        { json: "continue", js: "continue", typ: r("Continue") },
        { json: "convenience", js: "convenience", typ: r("Convenience") },
        { json: "convert", js: "convert", typ: r("Convert") },
        { json: "converter", js: "converter", typ: r("Converter") },
        { json: "dummy", js: "dummy", typ: i(0) },
    ], false),
    "Any": o([
        { json: "Any", js: "Any", typ: i(0) },
    ], false),
    "ArrayNode": o([
        { json: "ArrayNode", js: "ArrayNode", typ: i(0) },
    ], false),
    "Bool": o([
        { json: "BOOL", js: "BOOL", typ: i(0) },
    ], false),
    "BooleanNode": o([
        { json: "BooleanNode", js: "BooleanNode", typ: i(0) },
    ], false),
    "Calendar": o([
        { json: "Calendar", js: "Calendar", typ: i(0) },
    ], false),
    "Class": o([
        { json: "Class", js: "Class", typ: i(0) },
    ], false),
    "Codable": o([
        { json: "Codable", js: "Codable", typ: i(0) },
    ], false),
    "CodingKey": o([
        { json: "CodingKey", js: "CodingKey", typ: i(0) },
    ], false),
    "CodingKeys": o([
        { json: "CodingKeys", js: "CodingKeys", typ: i(0) },
    ], false),
    "Empty": o([
        { json: "_", js: "_", typ: i(0) },
    ], false),
    "BoolClass": o([
        { json: "_Bool", js: "_Bool", typ: i(0) },
    ], false),
    "Complex": o([
        { json: "_Complex", js: "_Complex", typ: i(0) },
    ], false),
    "Imaginery": o([
        { json: "_Imaginery", js: "_Imaginery", typ: i(0) },
    ], false),
    "Abstract": o([
        { json: "abstract", js: "abstract", typ: i(0) },
    ], false),
    "Alignas": o([
        { json: "alignas", js: "alignas", typ: i(0) },
    ], false),
    "Alignof": o([
        { json: "alignof", js: "alignof", typ: i(0) },
    ], false),
    "And": o([
        { json: "and", js: "and", typ: i(0) },
    ], false),
    "AndEq": o([
        { json: "and_eq", js: "and_eq", typ: i(0) },
    ], false),
    "AnyClass": o([
        { json: "any", js: "any", typ: i(0) },
    ], false),
    "Array": o([
        { json: "array", js: "array", typ: i(0) },
    ], false),
    "As": o([
        { json: "as", js: "as", typ: i(0) },
    ], false),
    "ASM": o([
        { json: "asm", js: "asm", typ: i(0) },
    ], false),
    "Assert": o([
        { json: "assert", js: "assert", typ: i(0) },
    ], false),
    "Associatedtype": o([
        { json: "associatedtype", js: "associatedtype", typ: i(0) },
    ], false),
    "Associativity": o([
        { json: "associativity", js: "associativity", typ: i(0) },
    ], false),
    "Async": o([
        { json: "async", js: "async", typ: i(0) },
    ], false),
    "Atomic": o([
        { json: "atomic", js: "atomic", typ: i(0) },
    ], false),
    "AtomicCancel": o([
        { json: "atomic_cancel", js: "atomic_cancel", typ: i(0) },
    ], false),
    "AtomicCommit": o([
        { json: "atomic_commit", js: "atomic_commit", typ: i(0) },
    ], false),
    "AtomicNoexcept": o([
        { json: "atomic_noexcept", js: "atomic_noexcept", typ: i(0) },
    ], false),
    "Auto": o([
        { json: "auto", js: "auto", typ: i(0) },
    ], false),
    "Await": o([
        { json: "await", js: "await", typ: i(0) },
    ], false),
    "Base": o([
        { json: "base", js: "base", typ: i(0) },
    ], false),
    "Bitand": o([
        { json: "bitand", js: "bitand", typ: i(0) },
    ], false),
    "Bitor": o([
        { json: "bitor", js: "bitor", typ: i(0) },
    ], false),
    "Obj1Bool": o([
        { json: "bool", js: "bool", typ: i(0) },
    ], false),
    "Boolean": o([
        { json: "boolean", js: "boolean", typ: i(0) },
    ], false),
    "Break": o([
        { json: "break", js: "break", typ: i(0) },
    ], false),
    "Bycopy": o([
        { json: "bycopy", js: "bycopy", typ: i(0) },
    ], false),
    "Byref": o([
        { json: "byref", js: "byref", typ: i(0) },
    ], false),
    "Byte": o([
        { json: "byte", js: "byte", typ: i(0) },
    ], false),
    "Case": o([
        { json: "case", js: "case", typ: i(0) },
    ], false),
    "Catch": o([
        { json: "catch", js: "catch", typ: i(0) },
    ], false),
    "Chan": o([
        { json: "chan", js: "chan", typ: i(0) },
    ], false),
    "Char": o([
        { json: "char", js: "char", typ: i(0) },
    ], false),
    "Char16T": o([
        { json: "char16_t", js: "char16_t", typ: i(0) },
    ], false),
    "Char32T": o([
        { json: "char32_t", js: "char32_t", typ: i(0) },
    ], false),
    "Checked": o([
        { json: "checked", js: "checked", typ: i(0) },
    ], false),
    "ClassClass": o([
        { json: "class", js: "class", typ: i(0) },
    ], false),
    "Clone": o([
        { json: "clone", js: "clone", typ: i(0) },
    ], false),
    "CoAwait": o([
        { json: "co_await", js: "co_await", typ: i(0) },
    ], false),
    "CoReturn": o([
        { json: "co_return", js: "co_return", typ: i(0) },
    ], false),
    "CoYield": o([
        { json: "co_yield", js: "co_yield", typ: i(0) },
    ], false),
    "Compl": o([
        { json: "compl", js: "compl", typ: i(0) },
    ], false),
    "Concept": o([
        { json: "concept", js: "concept", typ: i(0) },
    ], false),
    "Console": o([
        { json: "console", js: "console", typ: i(0) },
    ], false),
    "Const": o([
        { json: "const", js: "const", typ: i(0) },
    ], false),
    "ConstCast": o([
        { json: "const_cast", js: "const_cast", typ: i(0) },
    ], false),
    "Constexpr": o([
        { json: "constexpr", js: "constexpr", typ: i(0) },
    ], false),
    "Constructor": o([
        { json: "constructor", js: "constructor", typ: i(0) },
    ], false),
    "Continue": o([
        { json: "continue", js: "continue", typ: i(0) },
    ], false),
    "Convenience": o([
        { json: "convenience", js: "convenience", typ: i(0) },
    ], false),
    "Convert": o([
        { json: "convert", js: "convert", typ: i(0) },
    ], false),
    "Converter": o([
        { json: "converter", js: "converter", typ: i(0) },
    ], false),
    "Obj2": o([
        { json: "CultureInfo", js: "CultureInfo", typ: r("CultureInfo") },
        { json: "DateFormatter", js: "DateFormatter", typ: r("DateFormatter") },
        { json: "DateOnly", js: "DateOnly", typ: r("DateOnly") },
        { json: "DateOnlyConverter", js: "DateOnlyConverter", typ: r("DateOnlyConverter") },
        { json: "DateTime", js: "DateTime", typ: r("DateTime") },
        { json: "DateTimeStyles", js: "DateTimeStyles", typ: r("DateTimeStyles") },
        { json: "Decoder", js: "Decoder", typ: r("Decoder") },
        { json: "DecodingError", js: "DecodingError", typ: r("DecodingError") },
        { json: "DeserializationFeature", js: "DeserializationFeature", typ: r("DeserializationFeature") },
        { json: "DoubleNode", js: "DoubleNode", typ: r("DoubleNode") },
        { json: "Encoder", js: "Encoder", typ: r("Encoder") },
        { json: "EnumValues", js: "EnumValues", typ: r("EnumValues") },
        { json: "Equatable", js: "Equatable", typ: r("Equatable") },
        { json: "False", js: "False", typ: r("False") },
        { json: "FormatException", js: "FormatException", typ: r("FormatException") },
        { json: "date", js: "date", typ: r("Date") },
        { json: "date_parse_handling", js: "date_parse_handling", typ: r("DateParseHandling") },
        { json: "debugger", js: "debugger", typ: r("Debugger") },
        { json: "decimal", js: "decimal", typ: r("Decimal") },
        { json: "declare", js: "declare", typ: r("Declare") },
        { json: "decltype", js: "decltype", typ: r("Decltype") },
        { json: "decode_string", js: "decode_string", typ: r("DecodeString") },
        { json: "def", js: "def", typ: r("Def") },
        { json: "default", js: "default", typ: r("Default") },
        { json: "defer", js: "defer", typ: r("Defer") },
        { json: "deinit", js: "deinit", typ: r("Deinit") },
        { json: "del", js: "del", typ: r("Del") },
        { json: "delegate", js: "delegate", typ: r("Delegate") },
        { json: "delete", js: "delete", typ: r("Delete") },
        { json: "dict", js: "dict", typ: r("Dict") },
        { json: "dictionary", js: "dictionary", typ: r("Dictionary") },
        { json: "didSet", js: "didSet", typ: r("DidSet") },
        { json: "do", js: "do", typ: r("Do") },
        { json: "double", js: "double", typ: r("Double") },
        { json: "dummy", js: "dummy", typ: i(0) },
        { json: "dynamic", js: "dynamic", typ: r("Dynamic") },
        { json: "dynamic_cast", js: "dynamic_cast", typ: r("DynamicCast") },
        { json: "elif", js: "elif", typ: r("Elif") },
        { json: "else", js: "else", typ: r("Else") },
        { json: "encode_quick_type", js: "encode_quick_type", typ: r("EncodeQuickType") },
        { json: "enum", js: "enum", typ: r("Enum") },
        { json: "equalityContract", js: "equalityContract", typ: r("EqualityContract") },
        { json: "event", js: "event", typ: r("Event") },
        { json: "except", js: "except", typ: r("Except") },
        { json: "exception", js: "exception", typ: r("Exception") },
        { json: "explicit", js: "explicit", typ: r("Explicit") },
        { json: "export", js: "export", typ: r("Export") },
        { json: "exposing", js: "exposing", typ: r("Exposing") },
        { json: "extends", js: "extends", typ: r("Extends") },
        { json: "extension", js: "extension", typ: r("Extension") },
        { json: "extern", js: "extern", typ: r("Extern") },
        { json: "fallthrough", js: "fallthrough", typ: r("Fallthrough") },
        { json: "false", js: "false", typ: r("FalseClass") },
        { json: "fileprivate", js: "fileprivate", typ: r("Fileprivate") },
        { json: "final", js: "final", typ: r("Final") },
        { json: "finally", js: "finally", typ: r("Finally") },
        { json: "fixed", js: "fixed", typ: r("Fixed") },
        { json: "float", js: "float", typ: r("Float") },
        { json: "for", js: "for", typ: r("For") },
        { json: "foreach", js: "foreach", typ: r("Foreach") },
        { json: "friend", js: "friend", typ: r("Friend") },
        { json: "from", js: "from", typ: r("From") },
        { json: "from_dict", js: "from_dict", typ: r("FromDict") },
        { json: "from_json", js: "from_json", typ: r("FromJSON") },
        { json: "func", js: "func", typ: r("Func") },
    ], false),
    "CultureInfo": o([
        { json: "CultureInfo", js: "CultureInfo", typ: i(0) },
    ], false),
    "DateFormatter": o([
        { json: "DateFormatter", js: "DateFormatter", typ: i(0) },
    ], false),
    "DateOnly": o([
        { json: "DateOnly", js: "DateOnly", typ: i(0) },
    ], false),
    "DateOnlyConverter": o([
        { json: "DateOnlyConverter", js: "DateOnlyConverter", typ: i(0) },
    ], false),
    "DateTime": o([
        { json: "DateTime", js: "DateTime", typ: Date },
    ], false),
    "DateTimeStyles": o([
        { json: "DateTimeStyles", js: "DateTimeStyles", typ: i(0) },
    ], false),
    "Decoder": o([
        { json: "Decoder", js: "Decoder", typ: i(0) },
    ], false),
    "DecodingError": o([
        { json: "DecodingError", js: "DecodingError", typ: i(0) },
    ], false),
    "DeserializationFeature": o([
        { json: "DeserializationFeature", js: "DeserializationFeature", typ: i(0) },
    ], false),
    "DoubleNode": o([
        { json: "DoubleNode", js: "DoubleNode", typ: i(0) },
    ], false),
    "Encoder": o([
        { json: "Encoder", js: "Encoder", typ: i(0) },
    ], false),
    "EnumValues": o([
        { json: "EnumValues", js: "EnumValues", typ: a(r("EnumValue")) },
    ], false),
    "Equatable": o([
        { json: "Equatable", js: "Equatable", typ: i(0) },
    ], false),
    "False": o([
        { json: "False", js: "False", typ: i(0) },
    ], false),
    "FormatException": o([
        { json: "FormatException", js: "FormatException", typ: i(0) },
    ], false),
    "Date": o([
        { json: "date", js: "date", typ: i(0) },
    ], false),
    "DateParseHandling": o([
        { json: "date_parse_handling", js: "date_parse_handling", typ: i(0) },
    ], false),
    "Debugger": o([
        { json: "debugger", js: "debugger", typ: i(0) },
    ], false),
    "Decimal": o([
        { json: "decimal", js: "decimal", typ: i(0) },
    ], false),
    "Declare": o([
        { json: "declare", js: "declare", typ: i(0) },
    ], false),
    "Decltype": o([
        { json: "decltype", js: "decltype", typ: i(0) },
    ], false),
    "DecodeString": o([
        { json: "decode_string", js: "decode_string", typ: i(0) },
    ], false),
    "Def": o([
        { json: "def", js: "def", typ: i(0) },
    ], false),
    "Default": o([
        { json: "default", js: "default", typ: i(0) },
    ], false),
    "Defer": o([
        { json: "defer", js: "defer", typ: i(0) },
    ], false),
    "Deinit": o([
        { json: "deinit", js: "deinit", typ: i(0) },
    ], false),
    "Del": o([
        { json: "del", js: "del", typ: i(0) },
    ], false),
    "Delegate": o([
        { json: "delegate", js: "delegate", typ: i(0) },
    ], false),
    "Delete": o([
        { json: "delete", js: "delete", typ: i(0) },
    ], false),
    "Dict": o([
        { json: "dict", js: "dict", typ: i(0) },
    ], false),
    "Dictionary": o([
        { json: "dictionary", js: "dictionary", typ: i(0) },
    ], false),
    "DidSet": o([
        { json: "didSet", js: "didSet", typ: i(0) },
    ], false),
    "Do": o([
        { json: "do", js: "do", typ: i(0) },
    ], false),
    "Double": o([
        { json: "double", js: "double", typ: i(0) },
    ], false),
    "Dynamic": o([
        { json: "dynamic", js: "dynamic", typ: i(0) },
    ], false),
    "DynamicCast": o([
        { json: "dynamic_cast", js: "dynamic_cast", typ: i(0) },
    ], false),
    "Elif": o([
        { json: "elif", js: "elif", typ: i(0) },
    ], false),
    "Else": o([
        { json: "else", js: "else", typ: i(0) },
    ], false),
    "EncodeQuickType": o([
        { json: "encode_quick_type", js: "encode_quick_type", typ: i(0) },
    ], false),
    "Enum": o([
        { json: "enum", js: "enum", typ: i(0) },
    ], false),
    "EqualityContract": o([
        { json: "equalityContract", js: "equalityContract", typ: i(0) },
    ], false),
    "Event": o([
        { json: "event", js: "event", typ: i(0) },
    ], false),
    "Except": o([
        { json: "except", js: "except", typ: i(0) },
    ], false),
    "Exception": o([
        { json: "exception", js: "exception", typ: i(0) },
    ], false),
    "Explicit": o([
        { json: "explicit", js: "explicit", typ: i(0) },
    ], false),
    "Export": o([
        { json: "export", js: "export", typ: i(0) },
    ], false),
    "Exposing": o([
        { json: "exposing", js: "exposing", typ: i(0) },
    ], false),
    "Extends": o([
        { json: "extends", js: "extends", typ: i(0) },
    ], false),
    "Extension": o([
        { json: "extension", js: "extension", typ: i(0) },
    ], false),
    "Extern": o([
        { json: "extern", js: "extern", typ: i(0) },
    ], false),
    "Fallthrough": o([
        { json: "fallthrough", js: "fallthrough", typ: i(0) },
    ], false),
    "FalseClass": o([
        { json: "false", js: "false", typ: i(0) },
    ], false),
    "Fileprivate": o([
        { json: "fileprivate", js: "fileprivate", typ: i(0) },
    ], false),
    "Final": o([
        { json: "final", js: "final", typ: i(0) },
    ], false),
    "Finally": o([
        { json: "finally", js: "finally", typ: i(0) },
    ], false),
    "Fixed": o([
        { json: "fixed", js: "fixed", typ: i(0) },
    ], false),
    "Float": o([
        { json: "float", js: "float", typ: i(0) },
    ], false),
    "For": o([
        { json: "for", js: "for", typ: i(0) },
    ], false),
    "Foreach": o([
        { json: "foreach", js: "foreach", typ: i(0) },
    ], false),
    "Friend": o([
        { json: "friend", js: "friend", typ: i(0) },
    ], false),
    "From": o([
        { json: "from", js: "from", typ: i(0) },
    ], false),
    "FromDict": o([
        { json: "from_dict", js: "from_dict", typ: i(0) },
    ], false),
    "FromJSON": o([
        { json: "from_json", js: "from_json", typ: i(0) },
    ], false),
    "Func": o([
        { json: "func", js: "func", typ: i(0) },
    ], false),
    "Obj3": o([
        { json: "Hashable", js: "Hashable", typ: r("Hashable") },
        { json: "Hasher", js: "Hasher", typ: r("Hasher") },
        { json: "IMP", js: "IMP", typ: r("Imp") },
        { json: "IntNode", js: "IntNode", typ: r("IntNode") },
        { json: "IsoDateTimeOffsetConverter", js: "IsoDateTimeOffsetConverter", typ: r("ISODateTimeOffsetConverter") },
        { json: "JSONAny", js: "JSONAny", typ: r("JSONAny") },
        { json: "JSONCodingKey", js: "JSONCodingKey", typ: r("JSONCodingKey") },
        { json: "JSONDecoder", js: "JSONDecoder", typ: r("JSONDecoder") },
        { json: "JSONEncoder", js: "JSONEncoder", typ: r("JSONEncoder") },
        { json: "JSONNull", js: "JSONNull", typ: r("JSONNull") },
        { json: "JsonException", js: "JsonException", typ: r("JSONException") },
        { json: "JsonGenerator", js: "JsonGenerator", typ: r("JSONGenerator") },
        { json: "JsonNode", js: "JsonNode", typ: r("JSONNode") },
        { json: "JsonParser", js: "JsonParser", typ: r("JSONParser") },
        { json: "JsonReader", js: "JsonReader", typ: r("JSONReader") },
        { json: "JsonTokenType", js: "JsonTokenType", typ: r("JSONTokenType") },
        { json: "LocalDate", js: "LocalDate", typ: r("LocalDate") },
        { json: "Locale", js: "Locale", typ: r("Locale") },
        { json: "LongNode", js: "LongNode", typ: r("LongNode") },
        { json: "MapEntry", js: "MapEntry", typ: r("MapEntry") },
        { json: "MarshalJSON", js: "MarshalJSON", typ: r("MarshalJSON") },
        { json: "dummy", js: "dummy", typ: i(0) },
        { json: "function", js: "function", typ: r("Function") },
        { json: "get", js: "get", typ: r("Get") },
        { json: "global", js: "global", typ: r("Global") },
        { json: "go", js: "go", typ: r("Go") },
        { json: "goto", js: "goto", typ: r("Goto") },
        { json: "guard", js: "guard", typ: r("Guard") },
        { json: "hasOwnProperty", js: "hasOwnProperty", typ: r("HasOwnProperty") },
        { json: "hashCode", js: "hashCode", typ: r("HashCode") },
        { json: "id", js: "id", typ: r("ID") },
        { json: "if", js: "if", typ: r("If") },
        { json: "implements", js: "implements", typ: r("Implements") },
        { json: "implicit", js: "implicit", typ: r("Implicit") },
        { json: "import", js: "import", typ: r("Import") },
        { json: "in", js: "in", typ: r("In") },
        { json: "indirect", js: "indirect", typ: r("Indirect") },
        { json: "infix", js: "infix", typ: r("Infix") },
        { json: "init", js: "init", typ: r("Init") },
        { json: "inline", js: "inline", typ: r("Inline") },
        { json: "inout", js: "inout", typ: r("Inout") },
        { json: "instanceof", js: "instanceof", typ: r("Instanceof") },
        { json: "int", js: "int", typ: r("Int") },
        { json: "interface", js: "interface", typ: r("Interface") },
        { json: "internal", js: "internal", typ: r("Internal") },
        { json: "is", js: "is", typ: r("Is") },
        { json: "iterable", js: "iterable", typ: r("Iterable") },
        { json: "jdec", js: "jdec", typ: r("Jdec") },
        { json: "jenc", js: "jenc", typ: r("Jenc") },
        { json: "jpipe", js: "jpipe", typ: r("Jpipe") },
        { json: "json", js: "json", typ: r("JSON") },
        { json: "json_converter", js: "json_converter", typ: r("JSONConverter") },
        { json: "json_serializer", js: "json_serializer", typ: r("JSONSerializer") },
        { json: "json_token", js: "json_token", typ: r("JSONToken") },
        { json: "json_writer", js: "json_writer", typ: r("JSONWriter") },
        { json: "lambda", js: "lambda", typ: r("Lambda") },
        { json: "lazy", js: "lazy", typ: r("Lazy") },
        { json: "left", js: "left", typ: r("Left") },
        { json: "let", js: "let", typ: r("Let") },
        { json: "list", js: "list", typ: r("List") },
        { json: "lock", js: "lock", typ: r("Lock") },
        { json: "long", js: "long", typ: r("Long") },
        { json: "map", js: "map", typ: r("Map") },
        { json: "metadata_property_handling", js: "metadata_property_handling", typ: r("MetadataPropertyHandling") },
        { json: "module", js: "module", typ: r("Module") },
    ], false),
    "Hashable": o([
        { json: "Hashable", js: "Hashable", typ: i(0) },
    ], false),
    "Hasher": o([
        { json: "Hasher", js: "Hasher", typ: i(0) },
    ], false),
    "Imp": o([
        { json: "IMP", js: "IMP", typ: i(0) },
    ], false),
    "IntNode": o([
        { json: "IntNode", js: "IntNode", typ: i(0) },
    ], false),
    "ISODateTimeOffsetConverter": o([
        { json: "IsoDateTimeOffsetConverter", js: "IsoDateTimeOffsetConverter", typ: i(0) },
    ], false),
    "JSONAny": o([
        { json: "JSONAny", js: "JSONAny", typ: null },
    ], false),
    "JSONCodingKey": o([
        { json: "JSONCodingKey", js: "JSONCodingKey", typ: i(0) },
    ], false),
    "JSONDecoder": o([
        { json: "JSONDecoder", js: "JSONDecoder", typ: i(0) },
    ], false),
    "JSONEncoder": o([
        { json: "JSONEncoder", js: "JSONEncoder", typ: i(0) },
    ], false),
    "JSONNull": o([
        { json: "JSONNull", js: "JSONNull", typ: i(0) },
    ], false),
    "JSONException": o([
        { json: "JsonException", js: "JsonException", typ: i(0) },
    ], false),
    "JSONGenerator": o([
        { json: "JsonGenerator", js: "JsonGenerator", typ: i(0) },
    ], false),
    "JSONNode": o([
        { json: "JsonNode", js: "JsonNode", typ: i(0) },
    ], false),
    "JSONParser": o([
        { json: "JsonParser", js: "JsonParser", typ: i(0) },
    ], false),
    "JSONReader": o([
        { json: "JsonReader", js: "JsonReader", typ: i(0) },
    ], false),
    "JSONTokenType": o([
        { json: "JsonTokenType", js: "JsonTokenType", typ: i(0) },
    ], false),
    "LocalDate": o([
        { json: "LocalDate", js: "LocalDate", typ: i(0) },
    ], false),
    "Locale": o([
        { json: "Locale", js: "Locale", typ: i(0) },
    ], false),
    "LongNode": o([
        { json: "LongNode", js: "LongNode", typ: i(0) },
    ], false),
    "MapEntry": o([
        { json: "MapEntry", js: "MapEntry", typ: i(0) },
    ], false),
    "MarshalJSON": o([
        { json: "MarshalJSON", js: "MarshalJSON", typ: i(0) },
    ], false),
    "Function": o([
        { json: "function", js: "function", typ: i(0) },
    ], false),
    "Get": o([
        { json: "get", js: "get", typ: i(0) },
    ], false),
    "Global": o([
        { json: "global", js: "global", typ: i(0) },
    ], false),
    "Go": o([
        { json: "go", js: "go", typ: i(0) },
    ], false),
    "Goto": o([
        { json: "goto", js: "goto", typ: i(0) },
    ], false),
    "Guard": o([
        { json: "guard", js: "guard", typ: i(0) },
    ], false),
    "HasOwnProperty": o([
        { json: "hasOwnProperty", js: "hasOwnProperty", typ: i(0) },
    ], false),
    "HashCode": o([
        { json: "hashCode", js: "hashCode", typ: i(0) },
    ], false),
    "ID": o([
        { json: "id", js: "id", typ: i(0) },
    ], false),
    "If": o([
        { json: "if", js: "if", typ: i(0) },
    ], false),
    "Implements": o([
        { json: "implements", js: "implements", typ: i(0) },
    ], false),
    "Implicit": o([
        { json: "implicit", js: "implicit", typ: i(0) },
    ], false),
    "Import": o([
        { json: "import", js: "import", typ: i(0) },
    ], false),
    "In": o([
        { json: "in", js: "in", typ: i(0) },
    ], false),
    "Indirect": o([
        { json: "indirect", js: "indirect", typ: i(0) },
    ], false),
    "Infix": o([
        { json: "infix", js: "infix", typ: i(0) },
    ], false),
    "Init": o([
        { json: "init", js: "init", typ: i(0) },
    ], false),
    "Inline": o([
        { json: "inline", js: "inline", typ: i(0) },
    ], false),
    "Inout": o([
        { json: "inout", js: "inout", typ: i(0) },
    ], false),
    "Instanceof": o([
        { json: "instanceof", js: "instanceof", typ: i(0) },
    ], false),
    "Int": o([
        { json: "int", js: "int", typ: i(0) },
    ], false),
    "Interface": o([
        { json: "interface", js: "interface", typ: i(0) },
    ], false),
    "Internal": o([
        { json: "internal", js: "internal", typ: i(0) },
    ], false),
    "Is": o([
        { json: "is", js: "is", typ: i(0) },
    ], false),
    "Iterable": o([
        { json: "iterable", js: "iterable", typ: i(0) },
    ], false),
    "Jdec": o([
        { json: "jdec", js: "jdec", typ: i(0) },
    ], false),
    "Jenc": o([
        { json: "jenc", js: "jenc", typ: i(0) },
    ], false),
    "Jpipe": o([
        { json: "jpipe", js: "jpipe", typ: i(0) },
    ], false),
    "JSON": o([
        { json: "json", js: "json", typ: i(0) },
    ], false),
    "JSONConverter": o([
        { json: "json_converter", js: "json_converter", typ: i(0) },
    ], false),
    "JSONSerializer": o([
        { json: "json_serializer", js: "json_serializer", typ: i(0) },
    ], false),
    "JSONToken": o([
        { json: "json_token", js: "json_token", typ: i(0) },
    ], false),
    "JSONWriter": o([
        { json: "json_writer", js: "json_writer", typ: i(0) },
    ], false),
    "Lambda": o([
        { json: "lambda", js: "lambda", typ: i(0) },
    ], false),
    "Lazy": o([
        { json: "lazy", js: "lazy", typ: i(0) },
    ], false),
    "Left": o([
        { json: "left", js: "left", typ: i(0) },
    ], false),
    "Let": o([
        { json: "let", js: "let", typ: i(0) },
    ], false),
    "List": o([
        { json: "list", js: "list", typ: i(0) },
    ], false),
    "Lock": o([
        { json: "lock", js: "lock", typ: i(0) },
    ], false),
    "Long": o([
        { json: "long", js: "long", typ: i(0) },
    ], false),
    "Map": o([
        { json: "map", js: "map", typ: i(0) },
    ], false),
    "MetadataPropertyHandling": o([
        { json: "metadata_property_handling", js: "metadata_property_handling", typ: i(0) },
    ], false),
    "Module": o([
        { json: "module", js: "module", typ: i(0) },
    ], false),
    "Obj4": o([
        { json: "NO", js: "NO", typ: r("No") },
        { json: "NSError", js: "NSError", typ: r("NSError") },
        { json: "NSObject", js: "NSObject", typ: r("NSObject") },
        { json: "NSString", js: "NSString", typ: r("NSString") },
        { json: "NULL", js: "NULL", typ: r("Null") },
        { json: "None", js: "None", typ: r("None") },
        { json: "NullNode", js: "NullNode", typ: r("NullNode") },
        { json: "ObjectMapper", js: "ObjectMapper", typ: r("ObjectMapper") },
        { json: "ObjectNode", js: "ObjectNode", typ: r("ObjectNode") },
        { json: "ObjectReader", js: "ObjectReader", typ: r("ObjectReader") },
        { json: "ObjectWriter", js: "ObjectWriter", typ: r("ObjectWriter") },
        { json: "OffsetDateTime", js: "OffsetDateTime", typ: r("OffsetDateTime") },
        { json: "OffsetTime", js: "OffsetTime", typ: r("OffsetTime") },
        { json: "Protocol", js: "Protocol", typ: r("Protocol") },
        { json: "RegExp", js: "RegExp", typ: r("RegExp") },
        { json: "dummy", js: "dummy", typ: i(0) },
        { json: "mutable", js: "mutable", typ: r("Mutable") },
        { json: "mutating", js: "mutating", typ: r("Mutating") },
        { json: "namespace", js: "namespace", typ: r("Namespace") },
        { json: "native", js: "native", typ: r("Native") },
        { json: "new", js: "new", typ: r("New") },
        { json: "newtonsoft", js: "newtonsoft", typ: r("Newtonsoft") },
        { json: "nil", js: "nil", typ: r("Nil") },
        { json: "noSuchMethod", js: "noSuchMethod", typ: r("NoSuchMethod") },
        { json: "noexcept", js: "noexcept", typ: r("Noexcept") },
        { json: "nonatomic", js: "nonatomic", typ: r("Nonatomic") },
        { json: "none", js: "none", typ: r("NoneClass") },
        { json: "nonlocal", js: "nonlocal", typ: r("Nonlocal") },
        { json: "nonmutating", js: "nonmutating", typ: r("Nonmutating") },
        { json: "not", js: "not", typ: r("Not") },
        { json: "not_eq", js: "not_eq", typ: r("NotEq") },
        { json: "null", js: "null", typ: r("NullClass") },
        { json: "nullptr", js: "nullptr", typ: r("Nullptr") },
        { json: "number", js: "number", typ: r("Number") },
        { json: "object", js: "object", typ: r("Object") },
        { json: "of", js: "of", typ: r("Of") },
        { json: "oneway", js: "oneway", typ: r("Oneway") },
        { json: "open", js: "open", typ: r("Open") },
        { json: "operator", js: "operator", typ: r("Operator") },
        { json: "optional", js: "optional", typ: r("Optional") },
        { json: "or", js: "or", typ: r("Or") },
        { json: "or_eq", js: "or_eq", typ: r("OrEq") },
        { json: "out", js: "out", typ: r("Out") },
        { json: "override", js: "override", typ: r("Override") },
        { json: "package", js: "package", typ: r("Package") },
        { json: "params", js: "params", typ: r("Params") },
        { json: "pass", js: "pass", typ: r("Pass") },
        { json: "port", js: "port", typ: r("Port") },
        { json: "postfix", js: "postfix", typ: r("Postfix") },
        { json: "precedence", js: "precedence", typ: r("Precedence") },
        { json: "prefix", js: "prefix", typ: r("Prefix") },
        { json: "print", js: "print", typ: r("Print") },
        { json: "printMembers", js: "printMembers", typ: r("PrintMembers") },
        { json: "printf", js: "printf", typ: r("Printf") },
        { json: "private", js: "private", typ: r("Private") },
        { json: "protected", js: "protected", typ: r("Protected") },
        { json: "protocol", js: "protocol", typ: r("ProtocolClass") },
        { json: "public", js: "public", typ: r("Public") },
        { json: "quicktype", js: "quicktype", typ: r("Quicktype") },
        { json: "raise", js: "raise", typ: r("Raise") },
        { json: "range", js: "range", typ: r("Range") },
        { json: "readonly", js: "readonly", typ: r("Readonly") },
        { json: "ref", js: "ref", typ: r("Ref") },
        { json: "register", js: "register", typ: r("Register") },
        { json: "reinterpret_cast", js: "reinterpret_cast", typ: r("ReinterpretCast") },
    ], false),
    "No": o([
        { json: "NO", js: "NO", typ: i(0) },
    ], false),
    "NSError": o([
        { json: "NSError", js: "NSError", typ: i(0) },
    ], false),
    "NSObject": o([
        { json: "NSObject", js: "NSObject", typ: i(0) },
    ], false),
    "NSString": o([
        { json: "NSString", js: "NSString", typ: i(0) },
    ], false),
    "Null": o([
        { json: "NULL", js: "NULL", typ: i(0) },
    ], false),
    "None": o([
        { json: "None", js: "None", typ: i(0) },
    ], false),
    "NullNode": o([
        { json: "NullNode", js: "NullNode", typ: i(0) },
    ], false),
    "ObjectMapper": o([
        { json: "ObjectMapper", js: "ObjectMapper", typ: i(0) },
    ], false),
    "ObjectNode": o([
        { json: "ObjectNode", js: "ObjectNode", typ: i(0) },
    ], false),
    "ObjectReader": o([
        { json: "ObjectReader", js: "ObjectReader", typ: i(0) },
    ], false),
    "ObjectWriter": o([
        { json: "ObjectWriter", js: "ObjectWriter", typ: i(0) },
    ], false),
    "OffsetDateTime": o([
        { json: "OffsetDateTime", js: "OffsetDateTime", typ: i(0) },
    ], false),
    "OffsetTime": o([
        { json: "OffsetTime", js: "OffsetTime", typ: i(0) },
    ], false),
    "Protocol": o([
        { json: "Protocol", js: "Protocol", typ: i(0) },
    ], false),
    "RegExp": o([
        { json: "RegExp", js: "RegExp", typ: { uuid: "" } },
    ], false),
    "Mutable": o([
        { json: "mutable", js: "mutable", typ: i(0) },
    ], false),
    "Mutating": o([
        { json: "mutating", js: "mutating", typ: i(0) },
    ], false),
    "Namespace": o([
        { json: "namespace", js: "namespace", typ: i(0) },
    ], false),
    "Native": o([
        { json: "native", js: "native", typ: i(0) },
    ], false),
    "New": o([
        { json: "new", js: "new", typ: i(0) },
    ], false),
    "Newtonsoft": o([
        { json: "newtonsoft", js: "newtonsoft", typ: i(0) },
    ], false),
    "Nil": o([
        { json: "nil", js: "nil", typ: i(0) },
    ], false),
    "NoSuchMethod": o([
        { json: "noSuchMethod", js: "noSuchMethod", typ: i(0) },
    ], false),
    "Noexcept": o([
        { json: "noexcept", js: "noexcept", typ: i(0) },
    ], false),
    "Nonatomic": o([
        { json: "nonatomic", js: "nonatomic", typ: i(0) },
    ], false),
    "NoneClass": o([
        { json: "none", js: "none", typ: i(0) },
    ], false),
    "Nonlocal": o([
        { json: "nonlocal", js: "nonlocal", typ: i(0) },
    ], false),
    "Nonmutating": o([
        { json: "nonmutating", js: "nonmutating", typ: i(0) },
    ], false),
    "Not": o([
        { json: "not", js: "not", typ: i(0) },
    ], false),
    "NotEq": o([
        { json: "not_eq", js: "not_eq", typ: i(0) },
    ], false),
    "NullClass": o([
        { json: "null", js: "null", typ: i(0) },
    ], false),
    "Nullptr": o([
        { json: "nullptr", js: "nullptr", typ: i(0) },
    ], false),
    "Number": o([
        { json: "number", js: "number", typ: i(0) },
    ], false),
    "Object": o([
        { json: "object", js: "object", typ: i(0) },
    ], false),
    "Of": o([
        { json: "of", js: "of", typ: i(0) },
    ], false),
    "Oneway": o([
        { json: "oneway", js: "oneway", typ: i(0) },
    ], false),
    "Open": o([
        { json: "open", js: "open", typ: i(0) },
    ], false),
    "Operator": o([
        { json: "operator", js: "operator", typ: i(0) },
    ], false),
    "Optional": o([
        { json: "optional", js: "optional", typ: i(0) },
    ], false),
    "Or": o([
        { json: "or", js: "or", typ: i(0) },
    ], false),
    "OrEq": o([
        { json: "or_eq", js: "or_eq", typ: i(0) },
    ], false),
    "Out": o([
        { json: "out", js: "out", typ: i(0) },
    ], false),
    "Override": o([
        { json: "override", js: "override", typ: i(0) },
    ], false),
    "Package": o([
        { json: "package", js: "package", typ: i(0) },
    ], false),
    "Params": o([
        { json: "params", js: "params", typ: i(0) },
    ], false),
    "Pass": o([
        { json: "pass", js: "pass", typ: i(0) },
    ], false),
    "Port": o([
        { json: "port", js: "port", typ: i(0) },
    ], false),
    "Postfix": o([
        { json: "postfix", js: "postfix", typ: i(0) },
    ], false),
    "Precedence": o([
        { json: "precedence", js: "precedence", typ: i(0) },
    ], false),
    "Prefix": o([
        { json: "prefix", js: "prefix", typ: i(0) },
    ], false),
    "Print": o([
        { json: "print", js: "print", typ: i(0) },
    ], false),
    "PrintMembers": o([
        { json: "printMembers", js: "printMembers", typ: i(0) },
    ], false),
    "Printf": o([
        { json: "printf", js: "printf", typ: i(0) },
    ], false),
    "Private": o([
        { json: "private", js: "private", typ: i(0) },
    ], false),
    "Protected": o([
        { json: "protected", js: "protected", typ: i(0) },
    ], false),
    "ProtocolClass": o([
        { json: "protocol", js: "protocol", typ: i(0) },
    ], false),
    "Public": o([
        { json: "public", js: "public", typ: i(0) },
    ], false),
    "Quicktype": o([
        { json: "quicktype", js: "quicktype", typ: i(0) },
    ], false),
    "Raise": o([
        { json: "raise", js: "raise", typ: i(0) },
    ], false),
    "Range": o([
        { json: "range", js: "range", typ: i(0) },
    ], false),
    "Readonly": o([
        { json: "readonly", js: "readonly", typ: i(0) },
    ], false),
    "Ref": o([
        { json: "ref", js: "ref", typ: i(0) },
    ], false),
    "Register": o([
        { json: "register", js: "register", typ: i(0) },
    ], false),
    "ReinterpretCast": o([
        { json: "reinterpret_cast", js: "reinterpret_cast", typ: i(0) },
    ], false),
    "Obj5": o([
        { json: "KSerializer", js: "KSerializer", typ: r("KSerializer") },
        { json: "PrimitiveKind", js: "PrimitiveKind", typ: r("PrimitiveKind") },
        { json: "SEL", js: "SEL", typ: r("Sel") },
        { json: "Self", js: "Self", typ: r("Self") },
        { json: "Sendable", js: "Sendable", typ: r("Sendable") },
        { json: "SerialDescriptor", js: "SerialDescriptor", typ: r("SerialDescriptor") },
        { json: "SerialName", js: "SerialName", typ: r("SerialName") },
        { json: "Serializable", js: "Serializable", typ: r("Serializable") },
        { json: "SerializationFeature", js: "SerializationFeature", typ: r("SerializationFeature") },
        { json: "SerializerProvider", js: "SerializerProvider", typ: r("SerializerProvider") },
        { json: "SimpleModule", js: "SimpleModule", typ: r("SimpleModule") },
        { json: "Standards", js: "Standards", typ: r("Standards") },
        { json: "StdDeserializer", js: "StdDeserializer", typ: r("StdDeserializer") },
        { json: "StdSerializer", js: "StdSerializer", typ: r("StdSerializer") },
        { json: "TextNode", js: "TextNode", typ: r("TextNode") },
        { json: "TimeOnly", js: "TimeOnly", typ: r("TimeOnly") },
        { json: "TimeOnlyConverter", js: "TimeOnlyConverter", typ: r("TimeOnlyConverter") },
        { json: "TimeZone", js: "TimeZone", typ: r("TimeZone") },
        { json: "True", js: "True", typ: r("True") },
        { json: "dummy", js: "dummy", typ: i(0) },
        { json: "repeat", js: "repeat", typ: r("Repeat") },
        { json: "require", js: "require", typ: r("Require") },
        { json: "required", js: "required", typ: r("Required") },
        { json: "requires", js: "requires", typ: r("Requires") },
        { json: "restrict", js: "restrict", typ: r("Restrict") },
        { json: "retain", js: "retain", typ: r("Retain") },
        { json: "rethrows", js: "rethrows", typ: r("Rethrows") },
        { json: "return", js: "return", typ: r("Return") },
        { json: "right", js: "right", typ: r("Right") },
        { json: "runtimeType", js: "runtimeType", typ: r("RuntimeType") },
        { json: "s", js: "s", typ: r("S") },
        { json: "sbyte", js: "sbyte", typ: r("Sbyte") },
        { json: "sealed", js: "sealed", typ: r("Sealed") },
        { json: "select", js: "select", typ: r("Select") },
        { json: "self", js: "self", typ: r("SelfClass") },
        { json: "serialize", js: "serialize", typ: r("Serialize") },
        { json: "set", js: "set", typ: r("Set") },
        { json: "short", js: "short", typ: r("Short") },
        { json: "signed", js: "signed", typ: r("Signed") },
        { json: "sizeof", js: "sizeof", typ: r("Sizeof") },
        { json: "stackalloc", js: "stackalloc", typ: r("Stackalloc") },
        { json: "static", js: "static", typ: r("Static") },
        { json: "static_assert", js: "static_assert", typ: r("StaticAssert") },
        { json: "static_cast", js: "static_cast", typ: r("StaticCast") },
        { json: "strictfp", js: "strictfp", typ: r("Strictfp") },
        { json: "string", js: "string", typ: r("String") },
        { json: "struct", js: "struct", typ: r("Struct") },
        { json: "subscript", js: "subscript", typ: r("Subscript") },
        { json: "super", js: "super", typ: r("Super") },
        { json: "switch", js: "switch", typ: r("Switch") },
        { json: "symbol", js: "symbol", typ: r("Symbol") },
        { json: "synchronized", js: "synchronized", typ: r("Synchronized") },
        { json: "system", js: "system", typ: r("System") },
        { json: "template", js: "template", typ: r("Template") },
        { json: "then", js: "then", typ: r("Then") },
        { json: "this", js: "this", typ: r("This") },
        { json: "thread_local", js: "thread_local", typ: r("ThreadLocal") },
        { json: "throw", js: "throw", typ: r("Throw") },
        { json: "throws", js: "throws", typ: r("Throws") },
        { json: "toString", js: "toString", typ: r("ToString") },
        { json: "to_dict", js: "to_dict", typ: r("ToDict") },
        { json: "to_json", js: "to_json", typ: r("ToJSON") },
        { json: "top_level", js: "top_level", typ: r("TopLevelClass") },
        { json: "transient", js: "transient", typ: r("Transient") },
        { json: "true", js: "true", typ: r("TrueClass") },
    ], false),
    "KSerializer": o([
        { json: "KSerializer", js: "KSerializer", typ: i(0) },
    ], false),
    "PrimitiveKind": o([
        { json: "PrimitiveKind", js: "PrimitiveKind", typ: i(0) },
    ], false),
    "Sel": o([
        { json: "SEL", js: "SEL", typ: i(0) },
    ], false),
    "Self": o([
        { json: "Self", js: "Self", typ: i(0) },
    ], false),
    "Sendable": o([
        { json: "Sendable", js: "Sendable", typ: i(0) },
    ], false),
    "SerialDescriptor": o([
        { json: "SerialDescriptor", js: "SerialDescriptor", typ: i(0) },
    ], false),
    "SerialName": o([
        { json: "SerialName", js: "SerialName", typ: i(0) },
    ], false),
    "Serializable": o([
        { json: "Serializable", js: "Serializable", typ: i(0) },
    ], false),
    "SerializationFeature": o([
        { json: "SerializationFeature", js: "SerializationFeature", typ: i(0) },
    ], false),
    "SerializerProvider": o([
        { json: "SerializerProvider", js: "SerializerProvider", typ: i(0) },
    ], false),
    "SimpleModule": o([
        { json: "SimpleModule", js: "SimpleModule", typ: i(0) },
    ], false),
    "Standards": o([
        { json: "Standards", js: "Standards", typ: i(0) },
    ], false),
    "StdDeserializer": o([
        { json: "StdDeserializer", js: "StdDeserializer", typ: i(0) },
    ], false),
    "StdSerializer": o([
        { json: "StdSerializer", js: "StdSerializer", typ: i(0) },
    ], false),
    "TextNode": o([
        { json: "TextNode", js: "TextNode", typ: i(0) },
    ], false),
    "TimeOnly": o([
        { json: "TimeOnly", js: "TimeOnly", typ: i(0) },
    ], false),
    "TimeOnlyConverter": o([
        { json: "TimeOnlyConverter", js: "TimeOnlyConverter", typ: i(0) },
    ], false),
    "TimeZone": o([
        { json: "TimeZone", js: "TimeZone", typ: i(0) },
    ], false),
    "True": o([
        { json: "True", js: "True", typ: i(0) },
    ], false),
    "Repeat": o([
        { json: "repeat", js: "repeat", typ: i(0) },
    ], false),
    "Require": o([
        { json: "require", js: "require", typ: i(0) },
    ], false),
    "Required": o([
        { json: "required", js: "required", typ: i(0) },
    ], false),
    "Requires": o([
        { json: "requires", js: "requires", typ: i(0) },
    ], false),
    "Restrict": o([
        { json: "restrict", js: "restrict", typ: i(0) },
    ], false),
    "Retain": o([
        { json: "retain", js: "retain", typ: i(0) },
    ], false),
    "Rethrows": o([
        { json: "rethrows", js: "rethrows", typ: i(0) },
    ], false),
    "Return": o([
        { json: "return", js: "return", typ: i(0) },
    ], false),
    "Right": o([
        { json: "right", js: "right", typ: i(0) },
    ], false),
    "RuntimeType": o([
        { json: "runtimeType", js: "runtimeType", typ: i(0) },
    ], false),
    "S": o([
        { json: "s", js: "s", typ: i(0) },
    ], false),
    "Sbyte": o([
        { json: "sbyte", js: "sbyte", typ: i(0) },
    ], false),
    "Sealed": o([
        { json: "sealed", js: "sealed", typ: i(0) },
    ], false),
    "Select": o([
        { json: "select", js: "select", typ: i(0) },
    ], false),
    "SelfClass": o([
        { json: "self", js: "self", typ: i(0) },
    ], false),
    "Serialize": o([
        { json: "serialize", js: "serialize", typ: i(0) },
    ], false),
    "Set": o([
        { json: "set", js: "set", typ: i(0) },
    ], false),
    "Short": o([
        { json: "short", js: "short", typ: i(0) },
    ], false),
    "Signed": o([
        { json: "signed", js: "signed", typ: i(0) },
    ], false),
    "Sizeof": o([
        { json: "sizeof", js: "sizeof", typ: i(0) },
    ], false),
    "Stackalloc": o([
        { json: "stackalloc", js: "stackalloc", typ: i(0) },
    ], false),
    "Static": o([
        { json: "static", js: "static", typ: i(0) },
    ], false),
    "StaticAssert": o([
        { json: "static_assert", js: "static_assert", typ: i(0) },
    ], false),
    "StaticCast": o([
        { json: "static_cast", js: "static_cast", typ: i(0) },
    ], false),
    "Strictfp": o([
        { json: "strictfp", js: "strictfp", typ: i(0) },
    ], false),
    "String": o([
        { json: "string", js: "string", typ: i(0) },
    ], false),
    "Struct": o([
        { json: "struct", js: "struct", typ: i(0) },
    ], false),
    "Subscript": o([
        { json: "subscript", js: "subscript", typ: i(0) },
    ], false),
    "Super": o([
        { json: "super", js: "super", typ: i(0) },
    ], false),
    "Switch": o([
        { json: "switch", js: "switch", typ: i(0) },
    ], false),
    "Symbol": o([
        { json: "symbol", js: "symbol", typ: i(0) },
    ], false),
    "Synchronized": o([
        { json: "synchronized", js: "synchronized", typ: i(0) },
    ], false),
    "System": o([
        { json: "system", js: "system", typ: i(0) },
    ], false),
    "Template": o([
        { json: "template", js: "template", typ: i(0) },
    ], false),
    "Then": o([
        { json: "then", js: "then", typ: i(0) },
    ], false),
    "This": o([
        { json: "this", js: "this", typ: i(0) },
    ], false),
    "ThreadLocal": o([
        { json: "thread_local", js: "thread_local", typ: i(0) },
    ], false),
    "Throw": o([
        { json: "throw", js: "throw", typ: i(0) },
    ], false),
    "Throws": o([
        { json: "throws", js: "throws", typ: i(0) },
    ], false),
    "ToString": o([
        { json: "toString", js: "toString", typ: i(0) },
    ], false),
    "ToDict": o([
        { json: "to_dict", js: "to_dict", typ: i(0) },
    ], false),
    "ToJSON": o([
        { json: "to_json", js: "to_json", typ: i(0) },
    ], false),
    "TopLevelClass": o([
        { json: "top_level", js: "top_level", typ: i(0) },
    ], false),
    "Transient": o([
        { json: "transient", js: "transient", typ: i(0) },
    ], false),
    "TrueClass": o([
        { json: "true", js: "true", typ: i(0) },
    ], false),
    "Obj6": o([
        { json: "Type", js: "Type", typ: r("Type") },
        { json: "UUID", js: "UUID", typ: r("UUID") },
        { json: "UnmarshalJSON", js: "UnmarshalJSON", typ: r("UnmarshalJSON") },
        { json: "UseSerializers", js: "UseSerializers", typ: r("UseSerializers") },
        { json: "Utf8JsonReader", js: "Utf8JsonReader", typ: r("Utf8JSONReader") },
        { json: "Utf8JsonWriter", js: "Utf8JsonWriter", typ: r("Utf8JSONWriter") },
        { json: "YES", js: "YES", typ: r("Yes") },
        { json: "dummy", js: "dummy", typ: i(0) },
        { json: "try", js: "try", typ: r("Try") },
        { json: "type", js: "type", typ: r("TypeClass") },
        { json: "typealias", js: "typealias", typ: r("Typealias") },
        { json: "typedef", js: "typedef", typ: r("Typedef") },
        { json: "typeid", js: "typeid", typ: r("Typeid") },
        { json: "typename", js: "typename", typ: r("Typename") },
        { json: "typeof", js: "typeof", typ: r("Typeof") },
        { json: "uint", js: "uint", typ: r("Uint") },
        { json: "ulong", js: "ulong", typ: r("Ulong") },
        { json: "unchecked", js: "unchecked", typ: r("Unchecked") },
        { json: "undefined", js: "undefined", typ: r("Undefined") },
        { json: "union", js: "union", typ: r("Union") },
        { json: "unowned", js: "unowned", typ: r("Unowned") },
        { json: "unsafe", js: "unsafe", typ: r("Unsafe") },
        { json: "unsigned", js: "unsigned", typ: r("Unsigned") },
        { json: "ushort", js: "ushort", typ: r("Ushort") },
        { json: "using", js: "using", typ: r("Using") },
        { json: "var", js: "var", typ: r("Var") },
        { json: "virtual", js: "virtual", typ: r("Virtual") },
        { json: "void", js: "void", typ: r("Void") },
        { json: "volatile", js: "volatile", typ: r("Volatile") },
        { json: "wchar_t", js: "wchar_t", typ: r("WcharT") },
        { json: "weak", js: "weak", typ: r("Weak") },
        { json: "where", js: "where", typ: r("Where") },
        { json: "while", js: "while", typ: r("While") },
        { json: "willSet", js: "willSet", typ: r("WillSet") },
        { json: "with", js: "with", typ: r("With") },
        { json: "xor", js: "xor", typ: r("Xor") },
        { json: "xor_eq", js: "xor_eq", typ: r("XorEq") },
        { json: "yield", js: "yield", typ: r("Yield") },
    ], false),
    "Type": o([
        { json: "Type", js: "Type", typ: i(0) },
    ], false),
    "UUID": o([
        { json: "UUID", js: "UUID", typ: i(0) },
    ], false),
    "UnmarshalJSON": o([
        { json: "UnmarshalJSON", js: "UnmarshalJSON", typ: i(0) },
    ], false),
    "UseSerializers": o([
        { json: "UseSerializers", js: "UseSerializers", typ: i(0) },
    ], false),
    "Utf8JSONReader": o([
        { json: "Utf8JsonReader", js: "Utf8JsonReader", typ: i(0) },
    ], false),
    "Utf8JSONWriter": o([
        { json: "Utf8JsonWriter", js: "Utf8JsonWriter", typ: i(0) },
    ], false),
    "Yes": o([
        { json: "YES", js: "YES", typ: i(0) },
    ], false),
    "Try": o([
        { json: "try", js: "try", typ: i(0) },
    ], false),
    "TypeClass": o([
        { json: "type", js: "type", typ: i(0) },
    ], false),
    "Typealias": o([
        { json: "typealias", js: "typealias", typ: i(0) },
    ], false),
    "Typedef": o([
        { json: "typedef", js: "typedef", typ: i(0) },
    ], false),
    "Typeid": o([
        { json: "typeid", js: "typeid", typ: i(0) },
    ], false),
    "Typename": o([
        { json: "typename", js: "typename", typ: i(0) },
    ], false),
    "Typeof": o([
        { json: "typeof", js: "typeof", typ: i(0) },
    ], false),
    "Uint": o([
        { json: "uint", js: "uint", typ: i(0) },
    ], false),
    "Ulong": o([
        { json: "ulong", js: "ulong", typ: i(0) },
    ], false),
    "Unchecked": o([
        { json: "unchecked", js: "unchecked", typ: i(0) },
    ], false),
    "Undefined": o([
        { json: "undefined", js: "undefined", typ: i(0) },
    ], false),
    "Union": o([
        { json: "union", js: "union", typ: i(0) },
    ], false),
    "Unowned": o([
        { json: "unowned", js: "unowned", typ: i(0) },
    ], false),
    "Unsafe": o([
        { json: "unsafe", js: "unsafe", typ: i(0) },
    ], false),
    "Unsigned": o([
        { json: "unsigned", js: "unsigned", typ: i(0) },
    ], false),
    "Ushort": o([
        { json: "ushort", js: "ushort", typ: i(0) },
    ], false),
    "Using": o([
        { json: "using", js: "using", typ: i(0) },
    ], false),
    "Var": o([
        { json: "var", js: "var", typ: i(0) },
    ], false),
    "Virtual": o([
        { json: "virtual", js: "virtual", typ: i(0) },
    ], false),
    "Void": o([
        { json: "void", js: "void", typ: i(0) },
    ], false),
    "Volatile": o([
        { json: "volatile", js: "volatile", typ: i(0) },
    ], false),
    "WcharT": o([
        { json: "wchar_t", js: "wchar_t", typ: i(0) },
    ], false),
    "Weak": o([
        { json: "weak", js: "weak", typ: i(0) },
    ], false),
    "Where": o([
        { json: "where", js: "where", typ: i(0) },
    ], false),
    "While": o([
        { json: "while", js: "while", typ: i(0) },
    ], false),
    "WillSet": o([
        { json: "willSet", js: "willSet", typ: i(0) },
    ], false),
    "With": o([
        { json: "with", js: "with", typ: i(0) },
    ], false),
    "Xor": o([
        { json: "xor", js: "xor", typ: i(0) },
    ], false),
    "XorEq": o([
        { json: "xor_eq", js: "xor_eq", typ: i(0) },
    ], false),
    "Yield": o([
        { json: "yield", js: "yield", typ: i(0) },
    ], false),
    "EnumValue": [
        "ready",
        "done",
    ],
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};

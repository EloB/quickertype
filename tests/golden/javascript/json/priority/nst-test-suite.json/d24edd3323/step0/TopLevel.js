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
        { json: "y_array_arraysWithSpaces.json", js: "y_array_arraysWithSpaces.json", typ: a(a("any")) },
        { json: "y_array_empty-string.json", js: "y_array_empty-string.json", typ: a("") },
        { json: "y_array_empty.json", js: "y_array_empty.json", typ: a("any") },
        { json: "y_array_ending_with_newline.json", js: "y_array_ending_with_newline.json", typ: a("") },
        { json: "y_array_false.json", js: "y_array_false.json", typ: a(true) },
        { json: "y_array_heterogeneous.json", js: "y_array_heterogeneous.json", typ: a(u(r("JSON"), i(0), null, "")) },
        { json: "y_array_null.json", js: "y_array_null.json", typ: a(null) },
        { json: "y_array_with_1_and_newline.json", js: "y_array_with_1_and_newline.json", typ: a(i(0)) },
        { json: "y_array_with_leading_space.json", js: "y_array_with_leading_space.json", typ: a(i(0)) },
        { json: "y_array_with_several_null.json", js: "y_array_with_several_null.json", typ: a(u(i(0), null)) },
        { json: "y_array_with_trailing_space.json", js: "y_array_with_trailing_space.json", typ: a(i(0)) },
        { json: "y_number.json", js: "y_number.json", typ: a(3.14) },
        { json: "y_number_0e+1.json", js: "y_number_0e+1.json", typ: a(3.14) },
        { json: "y_number_0e1.json", js: "y_number_0e1.json", typ: a(3.14) },
        { json: "y_number_after_space.json", js: "y_number_after_space.json", typ: a(i(0)) },
        { json: "y_number_double_close_to_zero.json", js: "y_number_double_close_to_zero.json", typ: a(3.14) },
        { json: "y_number_int_with_exp.json", js: "y_number_int_with_exp.json", typ: a(3.14) },
        { json: "y_number_minus_zero.json", js: "y_number_minus_zero.json", typ: a(i(0)) },
        { json: "y_number_negative_int.json", js: "y_number_negative_int.json", typ: a(i(0)) },
        { json: "y_number_negative_one.json", js: "y_number_negative_one.json", typ: a(i(0)) },
        { json: "y_number_negative_zero.json", js: "y_number_negative_zero.json", typ: a(i(0)) },
        { json: "y_number_real_capital_e.json", js: "y_number_real_capital_e.json", typ: a(3.14) },
        { json: "y_number_real_capital_e_neg_exp.json", js: "y_number_real_capital_e_neg_exp.json", typ: a(3.14) },
        { json: "y_number_real_capital_e_pos_exp.json", js: "y_number_real_capital_e_pos_exp.json", typ: a(3.14) },
        { json: "y_number_real_exponent.json", js: "y_number_real_exponent.json", typ: a(3.14) },
        { json: "y_number_real_fraction_exponent.json", js: "y_number_real_fraction_exponent.json", typ: a(3.14) },
        { json: "y_number_real_neg_exp.json", js: "y_number_real_neg_exp.json", typ: a(3.14) },
        { json: "y_number_real_pos_exponent.json", js: "y_number_real_pos_exponent.json", typ: a(3.14) },
        { json: "y_number_simple_int.json", js: "y_number_simple_int.json", typ: a(i(0)) },
        { json: "y_number_simple_real.json", js: "y_number_simple_real.json", typ: a(3.14) },
        { json: "y_object.json", js: "y_object.json", typ: r("YObjectJSON") },
        { json: "y_object_basic.json", js: "y_object_basic.json", typ: r("YObjectBasicJSON") },
        { json: "y_object_empty.json", js: "y_object_empty.json", typ: r("JSON") },
        { json: "y_object_empty_key.json", js: "y_object_empty_key.json", typ: r("YObjectEmptyKeyJSON") },
        { json: "y_object_escaped_null_in_key.json", js: "y_object_escaped_null_in_key.json", typ: r("YObjectEscapedNullInKeyJSON") },
        { json: "y_object_extreme_numbers.json", js: "y_object_extreme_numbers.json", typ: r("YObjectExtremeNumbersJSON") },
        { json: "y_object_long_strings.json", js: "y_object_long_strings.json", typ: r("YObjectLongStringsJSON") },
        { json: "y_object_simple.json", js: "y_object_simple.json", typ: r("YObjectSimpleJSON") },
        { json: "y_object_string_unicode.json", js: "y_object_string_unicode.json", typ: r("YObjectStringUnicodeJSON") },
        { json: "y_object_with_newlines.json", js: "y_object_with_newlines.json", typ: r("YObjectWithNewlinesJSON") },
        { json: "y_string_1_2_3_bytes_UTF-8_sequences.json", js: "y_string_1_2_3_bytes_UTF-8_sequences.json", typ: a("") },
        { json: "y_string_accepted_surrogate_pair.json", js: "y_string_accepted_surrogate_pair.json", typ: a("") },
        { json: "y_string_accepted_surrogate_pairs.json", js: "y_string_accepted_surrogate_pairs.json", typ: a("") },
        { json: "y_string_allowed_escapes.json", js: "y_string_allowed_escapes.json", typ: a("") },
        { json: "y_string_backslash_and_u_escaped_zero.json", js: "y_string_backslash_and_u_escaped_zero.json", typ: a("") },
        { json: "y_string_backslash_doublequotes.json", js: "y_string_backslash_doublequotes.json", typ: a("") },
        { json: "y_string_comments.json", js: "y_string_comments.json", typ: a("") },
        { json: "y_string_double_escape_a.json", js: "y_string_double_escape_a.json", typ: a("") },
        { json: "y_string_double_escape_n.json", js: "y_string_double_escape_n.json", typ: a("") },
        { json: "y_string_escaped_control_character.json", js: "y_string_escaped_control_character.json", typ: a("") },
        { json: "y_string_escaped_noncharacter.json", js: "y_string_escaped_noncharacter.json", typ: a("") },
        { json: "y_string_in_array.json", js: "y_string_in_array.json", typ: a("") },
        { json: "y_string_in_array_with_leading_space.json", js: "y_string_in_array_with_leading_space.json", typ: a("") },
        { json: "y_string_last_surrogates_1_and_2.json", js: "y_string_last_surrogates_1_and_2.json", typ: a("") },
        { json: "y_string_nbsp_uescaped.json", js: "y_string_nbsp_uescaped.json", typ: a("") },
        { json: "y_string_nonCharacterInUTF-8_U+10FFFF.json", js: "y_string_nonCharacterInUTF-8_U+10FFFF.json", typ: a("") },
        { json: "y_string_nonCharacterInUTF-8_U+1FFFF.json", js: "y_string_nonCharacterInUTF-8_U+1FFFF.json", typ: a("") },
        { json: "y_string_nonCharacterInUTF-8_U+FFFF.json", js: "y_string_nonCharacterInUTF-8_U+FFFF.json", typ: a("") },
        { json: "y_string_null_escape.json", js: "y_string_null_escape.json", typ: a("") },
        { json: "y_string_one-byte-utf-8.json", js: "y_string_one-byte-utf-8.json", typ: a("") },
        { json: "y_string_pi.json", js: "y_string_pi.json", typ: a("") },
        { json: "y_string_simple_ascii.json", js: "y_string_simple_ascii.json", typ: a("") },
        { json: "y_string_space.json", js: "y_string_space.json", typ: "" },
        { json: "y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json", js: "y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json", typ: a("") },
        { json: "y_string_three-byte-utf-8.json", js: "y_string_three-byte-utf-8.json", typ: a("") },
        { json: "y_string_two-byte-utf-8.json", js: "y_string_two-byte-utf-8.json", typ: a("") },
        { json: "y_string_u+2028_line_sep.json", js: "y_string_u+2028_line_sep.json", typ: a("") },
        { json: "y_string_u+2029_par_sep.json", js: "y_string_u+2029_par_sep.json", typ: a("") },
        { json: "y_string_uEscape.json", js: "y_string_uEscape.json", typ: a("") },
        { json: "y_string_uescaped_newline.json", js: "y_string_uescaped_newline.json", typ: a("") },
        { json: "y_string_unescaped_char_delete.json", js: "y_string_unescaped_char_delete.json", typ: a("") },
        { json: "y_string_unicode.json", js: "y_string_unicode.json", typ: a("") },
        { json: "y_string_unicodeEscapedBackslash.json", js: "y_string_unicodeEscapedBackslash.json", typ: a("") },
        { json: "y_string_unicode_2.json", js: "y_string_unicode_2.json", typ: a("") },
        { json: "y_string_unicode_U+10FFFE_nonchar.json", js: "y_string_unicode_U+10FFFE_nonchar.json", typ: a("") },
        { json: "y_string_unicode_U+1FFFE_nonchar.json", js: "y_string_unicode_U+1FFFE_nonchar.json", typ: a("") },
        { json: "y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json", js: "y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json", typ: a("") },
        { json: "y_string_unicode_U+2064_invisible_plus.json", js: "y_string_unicode_U+2064_invisible_plus.json", typ: a("") },
        { json: "y_string_unicode_U+FDD0_nonchar.json", js: "y_string_unicode_U+FDD0_nonchar.json", typ: a("") },
        { json: "y_string_unicode_U+FFFE_nonchar.json", js: "y_string_unicode_U+FFFE_nonchar.json", typ: a("") },
        { json: "y_string_unicode_escaped_double_quote.json", js: "y_string_unicode_escaped_double_quote.json", typ: a("") },
        { json: "y_string_utf8.json", js: "y_string_utf8.json", typ: a("") },
        { json: "y_string_with_del_character.json", js: "y_string_with_del_character.json", typ: a("") },
        { json: "y_structure_lonely_false.json", js: "y_structure_lonely_false.json", typ: true },
        { json: "y_structure_lonely_int.json", js: "y_structure_lonely_int.json", typ: i(0) },
        { json: "y_structure_lonely_negative_real.json", js: "y_structure_lonely_negative_real.json", typ: 3.14 },
        { json: "y_structure_lonely_null.json", js: "y_structure_lonely_null.json", typ: null },
        { json: "y_structure_lonely_string.json", js: "y_structure_lonely_string.json", typ: "" },
        { json: "y_structure_lonely_true.json", js: "y_structure_lonely_true.json", typ: true },
        { json: "y_structure_string_empty.json", js: "y_structure_string_empty.json", typ: "" },
        { json: "y_structure_trailing_newline.json", js: "y_structure_trailing_newline.json", typ: a("") },
        { json: "y_structure_true_in_array.json", js: "y_structure_true_in_array.json", typ: a(true) },
        { json: "y_structure_whitespace_array.json", js: "y_structure_whitespace_array.json", typ: a("any") },
    ], false),
    "JSON": o([
    ], false),
    "YObjectJSON": o([
        { json: "asd", js: "asd", typ: "" },
        { json: "dfg", js: "dfg", typ: "" },
    ], false),
    "YObjectBasicJSON": o([
        { json: "asd", js: "asd", typ: "" },
    ], false),
    "YObjectEmptyKeyJSON": o([
        { json: "", js: "", typ: i(0) },
    ], false),
    "YObjectEscapedNullInKeyJSON": o([
        { json: "foo\u0000bar", js: "foo\u0000bar", typ: i(0) },
    ], false),
    "YObjectExtremeNumbersJSON": o([
        { json: "max", js: "max", typ: 3.14 },
        { json: "min", js: "min", typ: 3.14 },
    ], false),
    "YObjectLongStringsJSON": o([
        { json: "id", js: "id", typ: "" },
        { json: "x", js: "x", typ: a(r("X")) },
    ], false),
    "X": o([
        { json: "id", js: "id", typ: "" },
    ], false),
    "YObjectSimpleJSON": o([
        { json: "a", js: "a", typ: a("any") },
    ], false),
    "YObjectStringUnicodeJSON": o([
        { json: "title", js: "title", typ: "" },
    ], false),
    "YObjectWithNewlinesJSON": o([
        { json: "a", js: "a", typ: "" },
    ], false),
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};

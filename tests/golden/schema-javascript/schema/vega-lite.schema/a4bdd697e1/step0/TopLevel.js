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
        if ((typ.min !== undefined && val.length < typ.min) || (typ.max !== undefined && val.length > typ.max)) return invalidValue(l("array"), val, key, parent);
        return val.map(el => transform(el, typ.arrayItems, getProps));
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
            : typ.hasOwnProperty("arrayItems")    ? transformArray(typ, val)
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

function a(typ, min = undefined, max = undefined) {
    return { arrayItems: typ, min, max };
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
        { json: "$schema", js: "$schema", typ: u(undefined, "") },
        { json: "autosize", js: "autosize", typ: u(undefined, u(r("AutoSizeParams"), r("AutosizeType"))) },
        { json: "background", js: "background", typ: u(undefined, "") },
        { json: "config", js: "config", typ: u(undefined, r("Config")) },
        { json: "data", js: "data", typ: u(undefined, r("Data")) },
        { json: "description", js: "description", typ: u(undefined, "") },
        { json: "encoding", js: "encoding", typ: u(undefined, r("EncodingWithFacet")) },
        { json: "height", js: "height", typ: u(undefined, 3.14) },
        { json: "mark", js: "mark", typ: u(undefined, u(r("MarkDef"), r("Mark"))) },
        { json: "name", js: "name", typ: u(undefined, "") },
        { json: "padding", js: "padding", typ: u(undefined, u(r("PaddingClass"), 3.14)) },
        { json: "projection", js: "projection", typ: u(undefined, r("Projection")) },
        { json: "selection", js: "selection", typ: u(undefined, m(r("SelectionDef"))) },
        { json: "title", js: "title", typ: u(undefined, u(r("TitleParams"), "")) },
        { json: "transform", js: "transform", typ: u(undefined, a(r("Transform"))) },
        { json: "width", js: "width", typ: u(undefined, 3.14) },
        { json: "layer", js: "layer", typ: u(undefined, a(r("LayerSpec"))) },
        { json: "resolve", js: "resolve", typ: u(undefined, r("Resolve")) },
        { json: "facet", js: "facet", typ: u(undefined, r("FacetMapping")) },
        { json: "spec", js: "spec", typ: u(undefined, r("Spec")) },
        { json: "repeat", js: "repeat", typ: u(undefined, r("Repeat")) },
        { json: "vconcat", js: "vconcat", typ: u(undefined, a(r("Spec"))) },
        { json: "hconcat", js: "hconcat", typ: u(undefined, a(r("Spec"))) },
    ], false),
    "AutoSizeParams": o([
        { json: "contains", js: "contains", typ: u(undefined, r("Contains")) },
        { json: "resize", js: "resize", typ: u(undefined, true) },
        { json: "type", js: "type", typ: u(undefined, r("AutosizeType")) },
    ], false),
    "Config": o([
        { json: "area", js: "area", typ: u(undefined, r("MarkConfig")) },
        { json: "autosize", js: "autosize", typ: u(undefined, u(r("AutoSizeParams"), r("AutosizeType"))) },
        { json: "axis", js: "axis", typ: u(undefined, r("AxisConfig")) },
        { json: "axisBand", js: "axisBand", typ: u(undefined, r("VGAxisConfig")) },
        { json: "axisBottom", js: "axisBottom", typ: u(undefined, r("VGAxisConfig")) },
        { json: "axisLeft", js: "axisLeft", typ: u(undefined, r("VGAxisConfig")) },
        { json: "axisRight", js: "axisRight", typ: u(undefined, r("VGAxisConfig")) },
        { json: "axisTop", js: "axisTop", typ: u(undefined, r("VGAxisConfig")) },
        { json: "axisX", js: "axisX", typ: u(undefined, r("VGAxisConfig")) },
        { json: "axisY", js: "axisY", typ: u(undefined, r("VGAxisConfig")) },
        { json: "background", js: "background", typ: u(undefined, "") },
        { json: "bar", js: "bar", typ: u(undefined, r("BarConfig")) },
        { json: "circle", js: "circle", typ: u(undefined, r("MarkConfig")) },
        { json: "countTitle", js: "countTitle", typ: u(undefined, "") },
        { json: "fieldTitle", js: "fieldTitle", typ: u(undefined, r("FieldTitle")) },
        { json: "geoshape", js: "geoshape", typ: u(undefined, r("MarkConfig")) },
        { json: "invalidValues", js: "invalidValues", typ: u(undefined, r("InvalidValues")) },
        { json: "legend", js: "legend", typ: u(undefined, r("LegendConfig")) },
        { json: "line", js: "line", typ: u(undefined, r("MarkConfig")) },
        { json: "mark", js: "mark", typ: u(undefined, r("MarkConfig")) },
        { json: "numberFormat", js: "numberFormat", typ: u(undefined, "") },
        { json: "padding", js: "padding", typ: u(undefined, u(r("PaddingClass"), 3.14)) },
        { json: "point", js: "point", typ: u(undefined, r("MarkConfig")) },
        { json: "projection", js: "projection", typ: u(undefined, r("ProjectionConfig")) },
        { json: "range", js: "range", typ: u(undefined, r("RangeConfig")) },
        { json: "rect", js: "rect", typ: u(undefined, r("MarkConfig")) },
        { json: "rule", js: "rule", typ: u(undefined, r("MarkConfig")) },
        { json: "scale", js: "scale", typ: u(undefined, r("ScaleConfig")) },
        { json: "selection", js: "selection", typ: u(undefined, r("SelectionConfig")) },
        { json: "square", js: "square", typ: u(undefined, r("MarkConfig")) },
        { json: "stack", js: "stack", typ: u(undefined, r("StackOffset")) },
        { json: "style", js: "style", typ: u(undefined, m(r("VGMarkConfig"))) },
        { json: "text", js: "text", typ: u(undefined, r("TextConfig")) },
        { json: "tick", js: "tick", typ: u(undefined, r("TickConfig")) },
        { json: "timeFormat", js: "timeFormat", typ: u(undefined, "") },
        { json: "title", js: "title", typ: u(undefined, r("VGTitleConfig")) },
        { json: "view", js: "view", typ: u(undefined, r("ViewConfig")) },
    ], false),
    "MarkConfig": o([
        { json: "align", js: "align", typ: u(undefined, r("HorizontalAlign")) },
        { json: "angle", js: "angle", typ: u(undefined, n(3.14, 0, 360)) },
        { json: "baseline", js: "baseline", typ: u(undefined, r("VerticalAlign")) },
        { json: "color", js: "color", typ: u(undefined, "") },
        { json: "cursor", js: "cursor", typ: u(undefined, r("Cursor")) },
        { json: "dx", js: "dx", typ: u(undefined, 3.14) },
        { json: "dy", js: "dy", typ: u(undefined, 3.14) },
        { json: "fill", js: "fill", typ: u(undefined, "") },
        { json: "filled", js: "filled", typ: u(undefined, true) },
        { json: "fillOpacity", js: "fillOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "font", js: "font", typ: u(undefined, "") },
        { json: "fontSize", js: "fontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "fontStyle", js: "fontStyle", typ: u(undefined, r("FontStyle")) },
        { json: "fontWeight", js: "fontWeight", typ: u(undefined, u(n(3.14, 100, 900), r("FontWeight"))) },
        { json: "href", js: "href", typ: u(undefined, "") },
        { json: "interpolate", js: "interpolate", typ: u(undefined, r("Interpolate")) },
        { json: "limit", js: "limit", typ: u(undefined, 3.14) },
        { json: "opacity", js: "opacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "orient", js: "orient", typ: u(undefined, r("Orient")) },
        { json: "radius", js: "radius", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "shape", js: "shape", typ: u(undefined, "") },
        { json: "size", js: "size", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "stroke", js: "stroke", typ: u(undefined, "") },
        { json: "strokeDash", js: "strokeDash", typ: u(undefined, a(3.14)) },
        { json: "strokeDashOffset", js: "strokeDashOffset", typ: u(undefined, 3.14) },
        { json: "strokeOpacity", js: "strokeOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "strokeWidth", js: "strokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "tension", js: "tension", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "text", js: "text", typ: u(undefined, "") },
        { json: "theta", js: "theta", typ: u(undefined, 3.14) },
    ], false),
    "AxisConfig": o([
        { json: "bandPosition", js: "bandPosition", typ: u(undefined, 3.14) },
        { json: "domain", js: "domain", typ: u(undefined, true) },
        { json: "domainColor", js: "domainColor", typ: u(undefined, "") },
        { json: "domainWidth", js: "domainWidth", typ: u(undefined, 3.14) },
        { json: "grid", js: "grid", typ: u(undefined, true) },
        { json: "gridColor", js: "gridColor", typ: u(undefined, "") },
        { json: "gridDash", js: "gridDash", typ: u(undefined, a(3.14)) },
        { json: "gridOpacity", js: "gridOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "gridWidth", js: "gridWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "labelAngle", js: "labelAngle", typ: u(undefined, n(3.14, -360, 360)) },
        { json: "labelBound", js: "labelBound", typ: u(undefined, u(true, 3.14)) },
        { json: "labelColor", js: "labelColor", typ: u(undefined, "") },
        { json: "labelFlush", js: "labelFlush", typ: u(undefined, u(true, 3.14)) },
        { json: "labelFont", js: "labelFont", typ: u(undefined, "") },
        { json: "labelFontSize", js: "labelFontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "labelLimit", js: "labelLimit", typ: u(undefined, 3.14) },
        { json: "labelOverlap", js: "labelOverlap", typ: u(undefined, u(true, r("LabelOverlapEnum"))) },
        { json: "labelPadding", js: "labelPadding", typ: u(undefined, 3.14) },
        { json: "labels", js: "labels", typ: u(undefined, true) },
        { json: "maxExtent", js: "maxExtent", typ: u(undefined, 3.14) },
        { json: "minExtent", js: "minExtent", typ: u(undefined, 3.14) },
        { json: "shortTimeLabels", js: "shortTimeLabels", typ: u(undefined, true) },
        { json: "tickColor", js: "tickColor", typ: u(undefined, "") },
        { json: "tickRound", js: "tickRound", typ: u(undefined, true) },
        { json: "ticks", js: "ticks", typ: u(undefined, true) },
        { json: "tickSize", js: "tickSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "tickWidth", js: "tickWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "titleAlign", js: "titleAlign", typ: u(undefined, "") },
        { json: "titleAngle", js: "titleAngle", typ: u(undefined, 3.14) },
        { json: "titleBaseline", js: "titleBaseline", typ: u(undefined, "") },
        { json: "titleColor", js: "titleColor", typ: u(undefined, "") },
        { json: "titleFont", js: "titleFont", typ: u(undefined, "") },
        { json: "titleFontSize", js: "titleFontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "titleFontWeight", js: "titleFontWeight", typ: u(undefined, u(3.14, "")) },
        { json: "titleLimit", js: "titleLimit", typ: u(undefined, 3.14) },
        { json: "titleMaxLength", js: "titleMaxLength", typ: u(undefined, 3.14) },
        { json: "titlePadding", js: "titlePadding", typ: u(undefined, 3.14) },
        { json: "titleX", js: "titleX", typ: u(undefined, 3.14) },
        { json: "titleY", js: "titleY", typ: u(undefined, 3.14) },
    ], false),
    "VGAxisConfig": o([
        { json: "bandPosition", js: "bandPosition", typ: u(undefined, 3.14) },
        { json: "domain", js: "domain", typ: u(undefined, true) },
        { json: "domainColor", js: "domainColor", typ: u(undefined, "") },
        { json: "domainWidth", js: "domainWidth", typ: u(undefined, 3.14) },
        { json: "grid", js: "grid", typ: u(undefined, true) },
        { json: "gridColor", js: "gridColor", typ: u(undefined, "") },
        { json: "gridDash", js: "gridDash", typ: u(undefined, a(3.14)) },
        { json: "gridOpacity", js: "gridOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "gridWidth", js: "gridWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "labelAngle", js: "labelAngle", typ: u(undefined, n(3.14, -360, 360)) },
        { json: "labelBound", js: "labelBound", typ: u(undefined, u(true, 3.14)) },
        { json: "labelColor", js: "labelColor", typ: u(undefined, "") },
        { json: "labelFlush", js: "labelFlush", typ: u(undefined, u(true, 3.14)) },
        { json: "labelFont", js: "labelFont", typ: u(undefined, "") },
        { json: "labelFontSize", js: "labelFontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "labelLimit", js: "labelLimit", typ: u(undefined, 3.14) },
        { json: "labelOverlap", js: "labelOverlap", typ: u(undefined, u(true, r("LabelOverlapEnum"))) },
        { json: "labelPadding", js: "labelPadding", typ: u(undefined, 3.14) },
        { json: "labels", js: "labels", typ: u(undefined, true) },
        { json: "maxExtent", js: "maxExtent", typ: u(undefined, 3.14) },
        { json: "minExtent", js: "minExtent", typ: u(undefined, 3.14) },
        { json: "tickColor", js: "tickColor", typ: u(undefined, "") },
        { json: "tickRound", js: "tickRound", typ: u(undefined, true) },
        { json: "ticks", js: "ticks", typ: u(undefined, true) },
        { json: "tickSize", js: "tickSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "tickWidth", js: "tickWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "titleAlign", js: "titleAlign", typ: u(undefined, "") },
        { json: "titleAngle", js: "titleAngle", typ: u(undefined, 3.14) },
        { json: "titleBaseline", js: "titleBaseline", typ: u(undefined, "") },
        { json: "titleColor", js: "titleColor", typ: u(undefined, "") },
        { json: "titleFont", js: "titleFont", typ: u(undefined, "") },
        { json: "titleFontSize", js: "titleFontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "titleFontWeight", js: "titleFontWeight", typ: u(undefined, u(3.14, "")) },
        { json: "titleLimit", js: "titleLimit", typ: u(undefined, 3.14) },
        { json: "titleMaxLength", js: "titleMaxLength", typ: u(undefined, 3.14) },
        { json: "titlePadding", js: "titlePadding", typ: u(undefined, 3.14) },
        { json: "titleX", js: "titleX", typ: u(undefined, 3.14) },
        { json: "titleY", js: "titleY", typ: u(undefined, 3.14) },
    ], false),
    "BarConfig": o([
        { json: "align", js: "align", typ: u(undefined, r("HorizontalAlign")) },
        { json: "angle", js: "angle", typ: u(undefined, n(3.14, 0, 360)) },
        { json: "baseline", js: "baseline", typ: u(undefined, r("VerticalAlign")) },
        { json: "binSpacing", js: "binSpacing", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "color", js: "color", typ: u(undefined, "") },
        { json: "continuousBandSize", js: "continuousBandSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "cursor", js: "cursor", typ: u(undefined, r("Cursor")) },
        { json: "discreteBandSize", js: "discreteBandSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "dx", js: "dx", typ: u(undefined, 3.14) },
        { json: "dy", js: "dy", typ: u(undefined, 3.14) },
        { json: "fill", js: "fill", typ: u(undefined, "") },
        { json: "filled", js: "filled", typ: u(undefined, true) },
        { json: "fillOpacity", js: "fillOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "font", js: "font", typ: u(undefined, "") },
        { json: "fontSize", js: "fontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "fontStyle", js: "fontStyle", typ: u(undefined, r("FontStyle")) },
        { json: "fontWeight", js: "fontWeight", typ: u(undefined, u(n(3.14, 100, 900), r("FontWeight"))) },
        { json: "href", js: "href", typ: u(undefined, "") },
        { json: "interpolate", js: "interpolate", typ: u(undefined, r("Interpolate")) },
        { json: "limit", js: "limit", typ: u(undefined, 3.14) },
        { json: "opacity", js: "opacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "orient", js: "orient", typ: u(undefined, r("Orient")) },
        { json: "radius", js: "radius", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "shape", js: "shape", typ: u(undefined, "") },
        { json: "size", js: "size", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "stroke", js: "stroke", typ: u(undefined, "") },
        { json: "strokeDash", js: "strokeDash", typ: u(undefined, a(3.14)) },
        { json: "strokeDashOffset", js: "strokeDashOffset", typ: u(undefined, 3.14) },
        { json: "strokeOpacity", js: "strokeOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "strokeWidth", js: "strokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "tension", js: "tension", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "text", js: "text", typ: u(undefined, "") },
        { json: "theta", js: "theta", typ: u(undefined, 3.14) },
    ], false),
    "LegendConfig": o([
        { json: "cornerRadius", js: "cornerRadius", typ: u(undefined, 3.14) },
        { json: "entryPadding", js: "entryPadding", typ: u(undefined, 3.14) },
        { json: "fillColor", js: "fillColor", typ: u(undefined, "") },
        { json: "gradientHeight", js: "gradientHeight", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "gradientLabelBaseline", js: "gradientLabelBaseline", typ: u(undefined, "") },
        { json: "gradientLabelLimit", js: "gradientLabelLimit", typ: u(undefined, 3.14) },
        { json: "gradientLabelOffset", js: "gradientLabelOffset", typ: u(undefined, 3.14) },
        { json: "gradientStrokeColor", js: "gradientStrokeColor", typ: u(undefined, "") },
        { json: "gradientStrokeWidth", js: "gradientStrokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "gradientWidth", js: "gradientWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "labelAlign", js: "labelAlign", typ: u(undefined, "") },
        { json: "labelBaseline", js: "labelBaseline", typ: u(undefined, "") },
        { json: "labelColor", js: "labelColor", typ: u(undefined, "") },
        { json: "labelFont", js: "labelFont", typ: u(undefined, "") },
        { json: "labelFontSize", js: "labelFontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "labelLimit", js: "labelLimit", typ: u(undefined, 3.14) },
        { json: "labelOffset", js: "labelOffset", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "offset", js: "offset", typ: u(undefined, 3.14) },
        { json: "orient", js: "orient", typ: u(undefined, r("LegendOrient")) },
        { json: "padding", js: "padding", typ: u(undefined, 3.14) },
        { json: "shortTimeLabels", js: "shortTimeLabels", typ: u(undefined, true) },
        { json: "strokeColor", js: "strokeColor", typ: u(undefined, "") },
        { json: "strokeDash", js: "strokeDash", typ: u(undefined, a(3.14)) },
        { json: "strokeWidth", js: "strokeWidth", typ: u(undefined, 3.14) },
        { json: "symbolColor", js: "symbolColor", typ: u(undefined, "") },
        { json: "symbolSize", js: "symbolSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "symbolStrokeWidth", js: "symbolStrokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "symbolType", js: "symbolType", typ: u(undefined, "") },
        { json: "titleAlign", js: "titleAlign", typ: u(undefined, "") },
        { json: "titleBaseline", js: "titleBaseline", typ: u(undefined, "") },
        { json: "titleColor", js: "titleColor", typ: u(undefined, "") },
        { json: "titleFont", js: "titleFont", typ: u(undefined, "") },
        { json: "titleFontSize", js: "titleFontSize", typ: u(undefined, 3.14) },
        { json: "titleFontWeight", js: "titleFontWeight", typ: u(undefined, u(3.14, "")) },
        { json: "titleLimit", js: "titleLimit", typ: u(undefined, 3.14) },
        { json: "titlePadding", js: "titlePadding", typ: u(undefined, 3.14) },
    ], false),
    "PaddingClass": o([
        { json: "bottom", js: "bottom", typ: u(undefined, 3.14) },
        { json: "left", js: "left", typ: u(undefined, 3.14) },
        { json: "right", js: "right", typ: u(undefined, 3.14) },
        { json: "top", js: "top", typ: u(undefined, 3.14) },
    ], false),
    "ProjectionConfig": o([
        { json: "center", js: "center", typ: u(undefined, a(3.14)) },
        { json: "clipAngle", js: "clipAngle", typ: u(undefined, 3.14) },
        { json: "clipExtent", js: "clipExtent", typ: u(undefined, a(a(3.14))) },
        { json: "coefficient", js: "coefficient", typ: u(undefined, 3.14) },
        { json: "distance", js: "distance", typ: u(undefined, 3.14) },
        { json: "fraction", js: "fraction", typ: u(undefined, 3.14) },
        { json: "lobes", js: "lobes", typ: u(undefined, 3.14) },
        { json: "parallel", js: "parallel", typ: u(undefined, 3.14) },
        { json: "precision", js: "precision", typ: u(undefined, r("PurplePrecision")) },
        { json: "radius", js: "radius", typ: u(undefined, 3.14) },
        { json: "ratio", js: "ratio", typ: u(undefined, 3.14) },
        { json: "rotate", js: "rotate", typ: u(undefined, a(3.14)) },
        { json: "spacing", js: "spacing", typ: u(undefined, 3.14) },
        { json: "tilt", js: "tilt", typ: u(undefined, 3.14) },
        { json: "type", js: "type", typ: u(undefined, r("VGProjectionType")) },
    ], false),
    "PurplePrecision": o([
        { json: "length", js: "length", typ: 3.14 },
    ], ""),
    "RangeConfig": o([
        { json: "category", js: "category", typ: u(undefined, u(a(""), r("CategoryVGScheme"))) },
        { json: "diverging", js: "diverging", typ: u(undefined, u(a(""), r("CategoryVGScheme"))) },
        { json: "heatmap", js: "heatmap", typ: u(undefined, u(a(""), r("CategoryVGScheme"))) },
        { json: "ordinal", js: "ordinal", typ: u(undefined, u(a(""), r("CategoryVGScheme"))) },
        { json: "ramp", js: "ramp", typ: u(undefined, u(a(""), r("CategoryVGScheme"))) },
        { json: "symbol", js: "symbol", typ: u(undefined, a("")) },
    ], u(a(u(3.14, "")), r("RangeConfigValueVGScheme"))),
    "CategoryVGScheme": o([
        { json: "count", js: "count", typ: u(undefined, 3.14) },
        { json: "extent", js: "extent", typ: u(undefined, a(3.14)) },
        { json: "scheme", js: "scheme", typ: "" },
    ], false),
    "RangeConfigValueVGScheme": o([
        { json: "count", js: "count", typ: u(undefined, 3.14) },
        { json: "extent", js: "extent", typ: u(undefined, a(3.14)) },
        { json: "scheme", js: "scheme", typ: u(undefined, "") },
        { json: "step", js: "step", typ: u(undefined, 3.14) },
    ], false),
    "ScaleConfig": o([
        { json: "bandPaddingInner", js: "bandPaddingInner", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "bandPaddingOuter", js: "bandPaddingOuter", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "clamp", js: "clamp", typ: u(undefined, true) },
        { json: "continuousPadding", js: "continuousPadding", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "maxBandSize", js: "maxBandSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "maxFontSize", js: "maxFontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "maxOpacity", js: "maxOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "maxSize", js: "maxSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "maxStrokeWidth", js: "maxStrokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "minBandSize", js: "minBandSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "minFontSize", js: "minFontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "minOpacity", js: "minOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "minSize", js: "minSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "minStrokeWidth", js: "minStrokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "pointPadding", js: "pointPadding", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "rangeStep", js: "rangeStep", typ: u(undefined, u(n(3.14, 0, undefined), null)) },
        { json: "round", js: "round", typ: u(undefined, true) },
        { json: "textXRangeStep", js: "textXRangeStep", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "useUnaggregatedDomain", js: "useUnaggregatedDomain", typ: u(undefined, true) },
    ], false),
    "SelectionConfig": o([
        { json: "interval", js: "interval", typ: u(undefined, r("IntervalSelectionConfig")) },
        { json: "multi", js: "multi", typ: u(undefined, r("MultiSelectionConfig")) },
        { json: "single", js: "single", typ: u(undefined, r("SingleSelectionConfig")) },
    ], false),
    "IntervalSelectionConfig": o([
        { json: "bind", js: "bind", typ: u(undefined, r("BindEnum")) },
        { json: "empty", js: "empty", typ: u(undefined, r("Empty")) },
        { json: "encodings", js: "encodings", typ: u(undefined, a(r("SingleDefChannel"))) },
        { json: "fields", js: "fields", typ: u(undefined, a("")) },
        { json: "mark", js: "mark", typ: u(undefined, r("BrushConfig")) },
        { json: "on", js: "on", typ: u(undefined, "any") },
        { json: "resolve", js: "resolve", typ: u(undefined, r("SelectionResolution")) },
        { json: "translate", js: "translate", typ: u(undefined, u(true, "")) },
        { json: "zoom", js: "zoom", typ: u(undefined, u(true, "")) },
    ], false),
    "BrushConfig": o([
        { json: "fill", js: "fill", typ: u(undefined, "") },
        { json: "fillOpacity", js: "fillOpacity", typ: u(undefined, 3.14) },
        { json: "stroke", js: "stroke", typ: u(undefined, "") },
        { json: "strokeDash", js: "strokeDash", typ: u(undefined, a(3.14)) },
        { json: "strokeDashOffset", js: "strokeDashOffset", typ: u(undefined, 3.14) },
        { json: "strokeOpacity", js: "strokeOpacity", typ: u(undefined, 3.14) },
        { json: "strokeWidth", js: "strokeWidth", typ: u(undefined, 3.14) },
    ], false),
    "MultiSelectionConfig": o([
        { json: "empty", js: "empty", typ: u(undefined, r("Empty")) },
        { json: "encodings", js: "encodings", typ: u(undefined, a(r("SingleDefChannel"))) },
        { json: "fields", js: "fields", typ: u(undefined, a("")) },
        { json: "nearest", js: "nearest", typ: u(undefined, true) },
        { json: "on", js: "on", typ: u(undefined, "any") },
        { json: "resolve", js: "resolve", typ: u(undefined, r("SelectionResolution")) },
        { json: "toggle", js: "toggle", typ: u(undefined, u(true, "")) },
    ], false),
    "SingleSelectionConfig": o([
        { json: "bind", js: "bind", typ: u(undefined, m(r("VGBinding"))) },
        { json: "empty", js: "empty", typ: u(undefined, r("Empty")) },
        { json: "encodings", js: "encodings", typ: u(undefined, a(r("SingleDefChannel"))) },
        { json: "fields", js: "fields", typ: u(undefined, a("")) },
        { json: "nearest", js: "nearest", typ: u(undefined, true) },
        { json: "on", js: "on", typ: u(undefined, "any") },
        { json: "resolve", js: "resolve", typ: u(undefined, r("SelectionResolution")) },
    ], false),
    "VGBinding": o([
        { json: "element", js: "element", typ: u(undefined, "") },
        { json: "input", js: "input", typ: "" },
        { json: "options", js: "options", typ: u(undefined, a("")) },
        { json: "max", js: "max", typ: u(undefined, 3.14) },
        { json: "min", js: "min", typ: u(undefined, 3.14) },
        { json: "step", js: "step", typ: u(undefined, 3.14) },
    ], false),
    "VGMarkConfig": o([
        { json: "align", js: "align", typ: u(undefined, r("HorizontalAlign")) },
        { json: "angle", js: "angle", typ: u(undefined, n(3.14, 0, 360)) },
        { json: "baseline", js: "baseline", typ: u(undefined, r("VerticalAlign")) },
        { json: "cursor", js: "cursor", typ: u(undefined, r("Cursor")) },
        { json: "dx", js: "dx", typ: u(undefined, 3.14) },
        { json: "dy", js: "dy", typ: u(undefined, 3.14) },
        { json: "fill", js: "fill", typ: u(undefined, "") },
        { json: "fillOpacity", js: "fillOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "font", js: "font", typ: u(undefined, "") },
        { json: "fontSize", js: "fontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "fontStyle", js: "fontStyle", typ: u(undefined, r("FontStyle")) },
        { json: "fontWeight", js: "fontWeight", typ: u(undefined, u(n(3.14, 100, 900), r("FontWeight"))) },
        { json: "href", js: "href", typ: u(undefined, "") },
        { json: "interpolate", js: "interpolate", typ: u(undefined, r("Interpolate")) },
        { json: "limit", js: "limit", typ: u(undefined, 3.14) },
        { json: "opacity", js: "opacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "orient", js: "orient", typ: u(undefined, r("Orient")) },
        { json: "radius", js: "radius", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "shape", js: "shape", typ: u(undefined, "") },
        { json: "size", js: "size", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "stroke", js: "stroke", typ: u(undefined, "") },
        { json: "strokeDash", js: "strokeDash", typ: u(undefined, a(3.14)) },
        { json: "strokeDashOffset", js: "strokeDashOffset", typ: u(undefined, 3.14) },
        { json: "strokeOpacity", js: "strokeOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "strokeWidth", js: "strokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "tension", js: "tension", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "text", js: "text", typ: u(undefined, "") },
        { json: "theta", js: "theta", typ: u(undefined, 3.14) },
    ], false),
    "TextConfig": o([
        { json: "align", js: "align", typ: u(undefined, r("HorizontalAlign")) },
        { json: "angle", js: "angle", typ: u(undefined, n(3.14, 0, 360)) },
        { json: "baseline", js: "baseline", typ: u(undefined, r("VerticalAlign")) },
        { json: "color", js: "color", typ: u(undefined, "") },
        { json: "cursor", js: "cursor", typ: u(undefined, r("Cursor")) },
        { json: "dx", js: "dx", typ: u(undefined, 3.14) },
        { json: "dy", js: "dy", typ: u(undefined, 3.14) },
        { json: "fill", js: "fill", typ: u(undefined, "") },
        { json: "filled", js: "filled", typ: u(undefined, true) },
        { json: "fillOpacity", js: "fillOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "font", js: "font", typ: u(undefined, "") },
        { json: "fontSize", js: "fontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "fontStyle", js: "fontStyle", typ: u(undefined, r("FontStyle")) },
        { json: "fontWeight", js: "fontWeight", typ: u(undefined, u(n(3.14, 100, 900), r("FontWeight"))) },
        { json: "href", js: "href", typ: u(undefined, "") },
        { json: "interpolate", js: "interpolate", typ: u(undefined, r("Interpolate")) },
        { json: "limit", js: "limit", typ: u(undefined, 3.14) },
        { json: "opacity", js: "opacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "orient", js: "orient", typ: u(undefined, r("Orient")) },
        { json: "radius", js: "radius", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "shape", js: "shape", typ: u(undefined, "") },
        { json: "shortTimeLabels", js: "shortTimeLabels", typ: u(undefined, true) },
        { json: "size", js: "size", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "stroke", js: "stroke", typ: u(undefined, "") },
        { json: "strokeDash", js: "strokeDash", typ: u(undefined, a(3.14)) },
        { json: "strokeDashOffset", js: "strokeDashOffset", typ: u(undefined, 3.14) },
        { json: "strokeOpacity", js: "strokeOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "strokeWidth", js: "strokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "tension", js: "tension", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "text", js: "text", typ: u(undefined, "") },
        { json: "theta", js: "theta", typ: u(undefined, 3.14) },
    ], false),
    "TickConfig": o([
        { json: "align", js: "align", typ: u(undefined, r("HorizontalAlign")) },
        { json: "angle", js: "angle", typ: u(undefined, n(3.14, 0, 360)) },
        { json: "bandSize", js: "bandSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "baseline", js: "baseline", typ: u(undefined, r("VerticalAlign")) },
        { json: "color", js: "color", typ: u(undefined, "") },
        { json: "cursor", js: "cursor", typ: u(undefined, r("Cursor")) },
        { json: "dx", js: "dx", typ: u(undefined, 3.14) },
        { json: "dy", js: "dy", typ: u(undefined, 3.14) },
        { json: "fill", js: "fill", typ: u(undefined, "") },
        { json: "filled", js: "filled", typ: u(undefined, true) },
        { json: "fillOpacity", js: "fillOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "font", js: "font", typ: u(undefined, "") },
        { json: "fontSize", js: "fontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "fontStyle", js: "fontStyle", typ: u(undefined, r("FontStyle")) },
        { json: "fontWeight", js: "fontWeight", typ: u(undefined, u(n(3.14, 100, 900), r("FontWeight"))) },
        { json: "href", js: "href", typ: u(undefined, "") },
        { json: "interpolate", js: "interpolate", typ: u(undefined, r("Interpolate")) },
        { json: "limit", js: "limit", typ: u(undefined, 3.14) },
        { json: "opacity", js: "opacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "orient", js: "orient", typ: u(undefined, r("Orient")) },
        { json: "radius", js: "radius", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "shape", js: "shape", typ: u(undefined, "") },
        { json: "size", js: "size", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "stroke", js: "stroke", typ: u(undefined, "") },
        { json: "strokeDash", js: "strokeDash", typ: u(undefined, a(3.14)) },
        { json: "strokeDashOffset", js: "strokeDashOffset", typ: u(undefined, 3.14) },
        { json: "strokeOpacity", js: "strokeOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "strokeWidth", js: "strokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "tension", js: "tension", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "text", js: "text", typ: u(undefined, "") },
        { json: "theta", js: "theta", typ: u(undefined, 3.14) },
        { json: "thickness", js: "thickness", typ: u(undefined, n(3.14, 0, undefined)) },
    ], false),
    "VGTitleConfig": o([
        { json: "anchor", js: "anchor", typ: u(undefined, r("Anchor")) },
        { json: "angle", js: "angle", typ: u(undefined, 3.14) },
        { json: "baseline", js: "baseline", typ: u(undefined, r("VerticalAlign")) },
        { json: "color", js: "color", typ: u(undefined, "") },
        { json: "font", js: "font", typ: u(undefined, "") },
        { json: "fontSize", js: "fontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "fontWeight", js: "fontWeight", typ: u(undefined, u(n(3.14, 100, 900), r("FontWeight"))) },
        { json: "limit", js: "limit", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "offset", js: "offset", typ: u(undefined, 3.14) },
        { json: "orient", js: "orient", typ: u(undefined, r("TitleOrient")) },
    ], false),
    "ViewConfig": o([
        { json: "clip", js: "clip", typ: u(undefined, true) },
        { json: "fill", js: "fill", typ: u(undefined, "") },
        { json: "fillOpacity", js: "fillOpacity", typ: u(undefined, 3.14) },
        { json: "height", js: "height", typ: u(undefined, 3.14) },
        { json: "stroke", js: "stroke", typ: u(undefined, "") },
        { json: "strokeDash", js: "strokeDash", typ: u(undefined, a(3.14)) },
        { json: "strokeDashOffset", js: "strokeDashOffset", typ: u(undefined, 3.14) },
        { json: "strokeOpacity", js: "strokeOpacity", typ: u(undefined, 3.14) },
        { json: "strokeWidth", js: "strokeWidth", typ: u(undefined, 3.14) },
        { json: "width", js: "width", typ: u(undefined, 3.14) },
    ], false),
    "Data": o([
        { json: "format", js: "format", typ: u(undefined, r("DataFormat")) },
        { json: "url", js: "url", typ: u(undefined, "") },
        { json: "values", js: "values", typ: u(undefined, u(a(u(true, 3.14, m("any"), "")), m("any"), "")) },
        { json: "name", js: "name", typ: u(undefined, "") },
    ], false),
    "DataFormat": o([
        { json: "parse", js: "parse", typ: u(undefined, u(r("ParseEnum"), m("any"))) },
        { json: "type", js: "type", typ: u(undefined, r("DataFormatType")) },
        { json: "property", js: "property", typ: u(undefined, "") },
        { json: "feature", js: "feature", typ: u(undefined, "") },
        { json: "mesh", js: "mesh", typ: u(undefined, "") },
    ], false),
    "EncodingWithFacet": o([
        { json: "color", js: "color", typ: u(undefined, r("MarkPropDefWithCondition")) },
        { json: "column", js: "column", typ: u(undefined, r("FacetFieldDef")) },
        { json: "detail", js: "detail", typ: u(undefined, u(a(r("FieldDef")), r("FieldDef"))) },
        { json: "href", js: "href", typ: u(undefined, r("DefWithCondition")) },
        { json: "opacity", js: "opacity", typ: u(undefined, r("MarkPropDefWithCondition")) },
        { json: "order", js: "order", typ: u(undefined, u(a(r("OrderFieldDef")), r("OrderFieldDef"))) },
        { json: "row", js: "row", typ: u(undefined, r("FacetFieldDef")) },
        { json: "shape", js: "shape", typ: u(undefined, r("MarkPropDefWithCondition")) },
        { json: "size", js: "size", typ: u(undefined, r("MarkPropDefWithCondition")) },
        { json: "text", js: "text", typ: u(undefined, r("TextDefWithCondition")) },
        { json: "tooltip", js: "tooltip", typ: u(undefined, r("TextDefWithCondition")) },
        { json: "x", js: "x", typ: u(undefined, r("XClass")) },
        { json: "x2", js: "x2", typ: u(undefined, r("X2Class")) },
        { json: "y", js: "y", typ: u(undefined, r("XClass")) },
        { json: "y2", js: "y2", typ: u(undefined, r("X2Class")) },
    ], false),
    "MarkPropDefWithCondition": o([
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "condition", js: "condition", typ: u(undefined, u(a(r("ConditionalValueDef")), r("ConditionalPredicateMarkPropFieldDefClass"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "legend", js: "legend", typ: u(undefined, u(r("Legend"), null)) },
        { json: "scale", js: "scale", typ: u(undefined, r("Scale")) },
        { json: "sort", js: "sort", typ: u(undefined, u(r("SortField"), r("SortEnum"), null)) },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: u(undefined, r("Type")) },
        { json: "value", js: "value", typ: u(undefined, u(true, 3.14, "")) },
    ], false),
    "BinParams": o([
        { json: "base", js: "base", typ: u(undefined, 3.14) },
        { json: "divide", js: "divide", typ: u(undefined, a(3.14, 1, undefined)) },
        { json: "extent", js: "extent", typ: u(undefined, a(3.14, 2, 2)) },
        { json: "maxbins", js: "maxbins", typ: u(undefined, n(3.14, 2, undefined)) },
        { json: "minstep", js: "minstep", typ: u(undefined, 3.14) },
        { json: "nice", js: "nice", typ: u(undefined, true) },
        { json: "step", js: "step", typ: u(undefined, 3.14) },
        { json: "steps", js: "steps", typ: u(undefined, a(3.14, 1, undefined)) },
    ], false),
    "ConditionalValueDef": o([
        { json: "test", js: "test", typ: u(undefined, u(r("Predicate"), "")) },
        { json: "value", js: "value", typ: u(true, 3.14, "") },
        { json: "selection", js: "selection", typ: u(undefined, u(r("Selection"), "")) },
    ], false),
    "Selection": o([
        { json: "not", js: "not", typ: u(undefined, u(r("Selection"), "")) },
        { json: "and", js: "and", typ: u(undefined, a(u(r("Selection"), ""))) },
        { json: "or", js: "or", typ: u(undefined, a(u(r("Selection"), ""))) },
    ], false),
    "Predicate": o([
        { json: "not", js: "not", typ: u(undefined, u(r("Predicate"), "")) },
        { json: "and", js: "and", typ: u(undefined, a(u(r("Predicate"), ""))) },
        { json: "or", js: "or", typ: u(undefined, a(u(r("Predicate"), ""))) },
        { json: "equal", js: "equal", typ: u(undefined, u(true, r("DateTime"), 3.14, "")) },
        { json: "field", js: "field", typ: u(undefined, "") },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "range", js: "range", typ: u(undefined, a(u(r("DateTime"), 3.14, null), 2, 2)) },
        { json: "oneOf", js: "oneOf", typ: u(undefined, a(u(true, r("DateTime"), 3.14, ""))) },
        { json: "selection", js: "selection", typ: u(undefined, u(r("Selection"), "")) },
    ], false),
    "DateTime": o([
        { json: "date", js: "date", typ: u(undefined, n(3.14, 1, 31)) },
        { json: "day", js: "day", typ: u(undefined, u(n(3.14, 1, 7), "")) },
        { json: "hours", js: "hours", typ: u(undefined, n(3.14, 0, 23)) },
        { json: "milliseconds", js: "milliseconds", typ: u(undefined, n(3.14, 0, 999)) },
        { json: "minutes", js: "minutes", typ: u(undefined, n(3.14, 0, 59)) },
        { json: "month", js: "month", typ: u(undefined, u(n(3.14, 1, 12), "")) },
        { json: "quarter", js: "quarter", typ: u(undefined, n(3.14, 1, 4)) },
        { json: "seconds", js: "seconds", typ: u(undefined, n(3.14, 0, 59)) },
        { json: "utc", js: "utc", typ: u(undefined, true) },
        { json: "year", js: "year", typ: u(undefined, 3.14) },
    ], false),
    "ConditionalPredicateMarkPropFieldDefClass": o([
        { json: "test", js: "test", typ: u(undefined, u(r("Predicate"), "")) },
        { json: "value", js: "value", typ: u(undefined, u(true, 3.14, "")) },
        { json: "selection", js: "selection", typ: u(undefined, u(r("Selection"), "")) },
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "legend", js: "legend", typ: u(undefined, u(r("Legend"), null)) },
        { json: "scale", js: "scale", typ: u(undefined, r("Scale")) },
        { json: "sort", js: "sort", typ: u(undefined, u(r("SortField"), r("SortEnum"), null)) },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: u(undefined, r("Type")) },
    ], false),
    "RepeatRef": o([
        { json: "repeat", js: "repeat", typ: r("RepeatEnum") },
    ], false),
    "Legend": o([
        { json: "entryPadding", js: "entryPadding", typ: u(undefined, 3.14) },
        { json: "format", js: "format", typ: u(undefined, "") },
        { json: "offset", js: "offset", typ: u(undefined, 3.14) },
        { json: "orient", js: "orient", typ: u(undefined, r("LegendOrient")) },
        { json: "padding", js: "padding", typ: u(undefined, 3.14) },
        { json: "tickCount", js: "tickCount", typ: u(undefined, 3.14) },
        { json: "title", js: "title", typ: u(undefined, u(null, "")) },
        { json: "type", js: "type", typ: u(undefined, r("LegendType")) },
        { json: "values", js: "values", typ: u(undefined, a(u(r("DateTime"), 3.14, ""))) },
        { json: "zindex", js: "zindex", typ: u(undefined, n(3.14, 0, undefined)) },
    ], false),
    "Scale": o([
        { json: "base", js: "base", typ: u(undefined, 3.14) },
        { json: "clamp", js: "clamp", typ: u(undefined, true) },
        { json: "domain", js: "domain", typ: u(undefined, u(a(u(true, r("DateTime"), 3.14, "")), r("DomainClass"), r("Domain"))) },
        { json: "exponent", js: "exponent", typ: u(undefined, 3.14) },
        { json: "interpolate", js: "interpolate", typ: u(undefined, u(r("InterpolateParams"), r("Interpolate"))) },
        { json: "nice", js: "nice", typ: u(undefined, u(true, r("NiceClass"), 3.14, r("NiceTime"))) },
        { json: "padding", js: "padding", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "paddingInner", js: "paddingInner", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "paddingOuter", js: "paddingOuter", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "range", js: "range", typ: u(undefined, u(a(u(3.14, "")), "")) },
        { json: "rangeStep", js: "rangeStep", typ: u(undefined, u(n(3.14, 0, undefined), null)) },
        { json: "round", js: "round", typ: u(undefined, true) },
        { json: "scheme", js: "scheme", typ: u(undefined, u(r("SchemeParams"), "")) },
        { json: "type", js: "type", typ: u(undefined, r("ScaleType")) },
        { json: "zero", js: "zero", typ: u(undefined, true) },
    ], false),
    "DomainClass": o([
        { json: "field", js: "field", typ: u(undefined, "") },
        { json: "selection", js: "selection", typ: "" },
        { json: "encoding", js: "encoding", typ: u(undefined, "") },
    ], false),
    "InterpolateParams": o([
        { json: "gamma", js: "gamma", typ: u(undefined, 3.14) },
        { json: "type", js: "type", typ: r("InterpolateParamsType") },
    ], false),
    "NiceClass": o([
        { json: "interval", js: "interval", typ: "" },
        { json: "step", js: "step", typ: 3.14 },
    ], false),
    "SchemeParams": o([
        { json: "extent", js: "extent", typ: u(undefined, a(3.14)) },
        { json: "name", js: "name", typ: "" },
    ], false),
    "SortField": o([
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "op", js: "op", typ: r("AggregateOp") },
        { json: "order", js: "order", typ: u(undefined, u(r("SortEnum"), null)) },
    ], false),
    "FacetFieldDef": o([
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "header", js: "header", typ: u(undefined, r("Header")) },
        { json: "sort", js: "sort", typ: u(undefined, u(r("SortEnum"), null)) },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: r("Type") },
    ], false),
    "Header": o([
        { json: "format", js: "format", typ: u(undefined, "") },
        { json: "labelAngle", js: "labelAngle", typ: u(undefined, n(3.14, -360, 360)) },
        { json: "title", js: "title", typ: u(undefined, u(null, "")) },
    ], false),
    "FieldDef": o([
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: r("Type") },
    ], false),
    "DefWithCondition": o([
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "condition", js: "condition", typ: u(undefined, u(a(r("ConditionalValueDef")), r("ConditionalPredicateFieldDefClass"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: u(undefined, r("Type")) },
        { json: "value", js: "value", typ: u(undefined, u(true, 3.14, "")) },
    ], false),
    "ConditionalPredicateFieldDefClass": o([
        { json: "test", js: "test", typ: u(undefined, u(r("Predicate"), "")) },
        { json: "value", js: "value", typ: u(undefined, u(true, 3.14, "")) },
        { json: "selection", js: "selection", typ: u(undefined, u(r("Selection"), "")) },
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: u(undefined, r("Type")) },
    ], false),
    "OrderFieldDef": o([
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "sort", js: "sort", typ: u(undefined, u(r("SortEnum"), null)) },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: r("Type") },
    ], false),
    "TextDefWithCondition": o([
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "condition", js: "condition", typ: u(undefined, u(a(r("ConditionalValueDef")), r("ConditionalPredicateTextFieldDefClass"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "format", js: "format", typ: u(undefined, "") },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: u(undefined, r("Type")) },
        { json: "value", js: "value", typ: u(undefined, u(true, 3.14, "")) },
    ], false),
    "ConditionalPredicateTextFieldDefClass": o([
        { json: "test", js: "test", typ: u(undefined, u(r("Predicate"), "")) },
        { json: "value", js: "value", typ: u(undefined, u(true, 3.14, "")) },
        { json: "selection", js: "selection", typ: u(undefined, u(r("Selection"), "")) },
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "format", js: "format", typ: u(undefined, "") },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: u(undefined, r("Type")) },
    ], false),
    "XClass": o([
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "axis", js: "axis", typ: u(undefined, u(r("Axis"), null)) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "scale", js: "scale", typ: u(undefined, r("Scale")) },
        { json: "sort", js: "sort", typ: u(undefined, u(r("SortField"), r("SortEnum"), null)) },
        { json: "stack", js: "stack", typ: u(undefined, u(r("StackOffset"), null)) },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: u(undefined, r("Type")) },
        { json: "value", js: "value", typ: u(undefined, u(true, 3.14, "")) },
    ], false),
    "Axis": o([
        { json: "domain", js: "domain", typ: u(undefined, true) },
        { json: "format", js: "format", typ: u(undefined, "") },
        { json: "grid", js: "grid", typ: u(undefined, true) },
        { json: "labelAngle", js: "labelAngle", typ: u(undefined, n(3.14, -360, 360)) },
        { json: "labelBound", js: "labelBound", typ: u(undefined, u(true, 3.14)) },
        { json: "labelFlush", js: "labelFlush", typ: u(undefined, u(true, 3.14)) },
        { json: "labelOverlap", js: "labelOverlap", typ: u(undefined, u(true, r("LabelOverlapEnum"))) },
        { json: "labelPadding", js: "labelPadding", typ: u(undefined, 3.14) },
        { json: "labels", js: "labels", typ: u(undefined, true) },
        { json: "maxExtent", js: "maxExtent", typ: u(undefined, 3.14) },
        { json: "minExtent", js: "minExtent", typ: u(undefined, 3.14) },
        { json: "offset", js: "offset", typ: u(undefined, 3.14) },
        { json: "orient", js: "orient", typ: u(undefined, r("TitleOrient")) },
        { json: "position", js: "position", typ: u(undefined, 3.14) },
        { json: "tickCount", js: "tickCount", typ: u(undefined, 3.14) },
        { json: "ticks", js: "ticks", typ: u(undefined, true) },
        { json: "tickSize", js: "tickSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "title", js: "title", typ: u(undefined, u(null, "")) },
        { json: "titleMaxLength", js: "titleMaxLength", typ: u(undefined, 3.14) },
        { json: "titlePadding", js: "titlePadding", typ: u(undefined, 3.14) },
        { json: "values", js: "values", typ: u(undefined, a(u(r("DateTime"), 3.14))) },
        { json: "zindex", js: "zindex", typ: u(undefined, n(3.14, 0, undefined)) },
    ], false),
    "X2Class": o([
        { json: "aggregate", js: "aggregate", typ: u(undefined, r("AggregateOp")) },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "field", js: "field", typ: u(undefined, u(r("RepeatRef"), "")) },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "type", js: "type", typ: u(undefined, r("Type")) },
        { json: "value", js: "value", typ: u(undefined, u(true, 3.14, "")) },
    ], false),
    "FacetMapping": o([
        { json: "column", js: "column", typ: u(undefined, r("FacetFieldDef")) },
        { json: "row", js: "row", typ: u(undefined, r("FacetFieldDef")) },
    ], false),
    "Spec": o([
        { json: "data", js: "data", typ: u(undefined, r("Data")) },
        { json: "description", js: "description", typ: u(undefined, "") },
        { json: "height", js: "height", typ: u(undefined, 3.14) },
        { json: "layer", js: "layer", typ: u(undefined, a(r("LayerSpec"))) },
        { json: "name", js: "name", typ: u(undefined, "") },
        { json: "resolve", js: "resolve", typ: u(undefined, r("Resolve")) },
        { json: "title", js: "title", typ: u(undefined, u(r("TitleParams"), "")) },
        { json: "transform", js: "transform", typ: u(undefined, a(r("Transform"))) },
        { json: "width", js: "width", typ: u(undefined, 3.14) },
        { json: "encoding", js: "encoding", typ: u(undefined, r("Encoding")) },
        { json: "mark", js: "mark", typ: u(undefined, u(r("MarkDef"), r("Mark"))) },
        { json: "projection", js: "projection", typ: u(undefined, r("Projection")) },
        { json: "selection", js: "selection", typ: u(undefined, m(r("SelectionDef"))) },
        { json: "facet", js: "facet", typ: u(undefined, r("FacetMapping")) },
        { json: "spec", js: "spec", typ: u(undefined, r("Spec")) },
        { json: "repeat", js: "repeat", typ: u(undefined, r("Repeat")) },
        { json: "vconcat", js: "vconcat", typ: u(undefined, a(r("Spec"))) },
        { json: "hconcat", js: "hconcat", typ: u(undefined, a(r("Spec"))) },
    ], false),
    "Encoding": o([
        { json: "color", js: "color", typ: u(undefined, r("MarkPropDefWithCondition")) },
        { json: "detail", js: "detail", typ: u(undefined, u(a(r("FieldDef")), r("FieldDef"))) },
        { json: "href", js: "href", typ: u(undefined, r("DefWithCondition")) },
        { json: "opacity", js: "opacity", typ: u(undefined, r("MarkPropDefWithCondition")) },
        { json: "order", js: "order", typ: u(undefined, u(a(r("OrderFieldDef")), r("OrderFieldDef"))) },
        { json: "shape", js: "shape", typ: u(undefined, r("MarkPropDefWithCondition")) },
        { json: "size", js: "size", typ: u(undefined, r("MarkPropDefWithCondition")) },
        { json: "text", js: "text", typ: u(undefined, r("TextDefWithCondition")) },
        { json: "tooltip", js: "tooltip", typ: u(undefined, r("TextDefWithCondition")) },
        { json: "x", js: "x", typ: u(undefined, r("XClass")) },
        { json: "x2", js: "x2", typ: u(undefined, r("X2Class")) },
        { json: "y", js: "y", typ: u(undefined, r("XClass")) },
        { json: "y2", js: "y2", typ: u(undefined, r("X2Class")) },
    ], false),
    "LayerSpec": o([
        { json: "data", js: "data", typ: u(undefined, r("Data")) },
        { json: "description", js: "description", typ: u(undefined, "") },
        { json: "height", js: "height", typ: u(undefined, 3.14) },
        { json: "layer", js: "layer", typ: u(undefined, a(r("LayerSpec"))) },
        { json: "name", js: "name", typ: u(undefined, "") },
        { json: "resolve", js: "resolve", typ: u(undefined, r("Resolve")) },
        { json: "title", js: "title", typ: u(undefined, u(r("TitleParams"), "")) },
        { json: "transform", js: "transform", typ: u(undefined, a(r("Transform"))) },
        { json: "width", js: "width", typ: u(undefined, 3.14) },
        { json: "encoding", js: "encoding", typ: u(undefined, r("Encoding")) },
        { json: "mark", js: "mark", typ: u(undefined, u(r("MarkDef"), r("Mark"))) },
        { json: "projection", js: "projection", typ: u(undefined, r("Projection")) },
        { json: "selection", js: "selection", typ: u(undefined, m(r("SelectionDef"))) },
    ], false),
    "MarkDef": o([
        { json: "align", js: "align", typ: u(undefined, r("HorizontalAlign")) },
        { json: "angle", js: "angle", typ: u(undefined, n(3.14, 0, 360)) },
        { json: "baseline", js: "baseline", typ: u(undefined, r("VerticalAlign")) },
        { json: "clip", js: "clip", typ: u(undefined, true) },
        { json: "color", js: "color", typ: u(undefined, "") },
        { json: "cursor", js: "cursor", typ: u(undefined, r("Cursor")) },
        { json: "dx", js: "dx", typ: u(undefined, 3.14) },
        { json: "dy", js: "dy", typ: u(undefined, 3.14) },
        { json: "fill", js: "fill", typ: u(undefined, "") },
        { json: "filled", js: "filled", typ: u(undefined, true) },
        { json: "fillOpacity", js: "fillOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "font", js: "font", typ: u(undefined, "") },
        { json: "fontSize", js: "fontSize", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "fontStyle", js: "fontStyle", typ: u(undefined, r("FontStyle")) },
        { json: "fontWeight", js: "fontWeight", typ: u(undefined, u(n(3.14, 100, 900), r("FontWeight"))) },
        { json: "href", js: "href", typ: u(undefined, "") },
        { json: "interpolate", js: "interpolate", typ: u(undefined, r("Interpolate")) },
        { json: "limit", js: "limit", typ: u(undefined, 3.14) },
        { json: "opacity", js: "opacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "orient", js: "orient", typ: u(undefined, r("Orient")) },
        { json: "radius", js: "radius", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "shape", js: "shape", typ: u(undefined, "") },
        { json: "size", js: "size", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "stroke", js: "stroke", typ: u(undefined, "") },
        { json: "strokeDash", js: "strokeDash", typ: u(undefined, a(3.14)) },
        { json: "strokeDashOffset", js: "strokeDashOffset", typ: u(undefined, 3.14) },
        { json: "strokeOpacity", js: "strokeOpacity", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "strokeWidth", js: "strokeWidth", typ: u(undefined, n(3.14, 0, undefined)) },
        { json: "style", js: "style", typ: u(undefined, u(a(""), "")) },
        { json: "tension", js: "tension", typ: u(undefined, n(3.14, 0, 1)) },
        { json: "text", js: "text", typ: u(undefined, "") },
        { json: "theta", js: "theta", typ: u(undefined, 3.14) },
        { json: "type", js: "type", typ: r("Mark") },
    ], false),
    "Projection": o([
        { json: "center", js: "center", typ: u(undefined, a(3.14)) },
        { json: "clipAngle", js: "clipAngle", typ: u(undefined, 3.14) },
        { json: "clipExtent", js: "clipExtent", typ: u(undefined, a(a(3.14))) },
        { json: "coefficient", js: "coefficient", typ: u(undefined, 3.14) },
        { json: "distance", js: "distance", typ: u(undefined, 3.14) },
        { json: "fraction", js: "fraction", typ: u(undefined, 3.14) },
        { json: "lobes", js: "lobes", typ: u(undefined, 3.14) },
        { json: "parallel", js: "parallel", typ: u(undefined, 3.14) },
        { json: "precision", js: "precision", typ: u(undefined, r("FluffyPrecision")) },
        { json: "radius", js: "radius", typ: u(undefined, 3.14) },
        { json: "ratio", js: "ratio", typ: u(undefined, 3.14) },
        { json: "rotate", js: "rotate", typ: u(undefined, a(3.14)) },
        { json: "spacing", js: "spacing", typ: u(undefined, 3.14) },
        { json: "tilt", js: "tilt", typ: u(undefined, 3.14) },
        { json: "type", js: "type", typ: u(undefined, r("VGProjectionType")) },
    ], false),
    "FluffyPrecision": o([
        { json: "length", js: "length", typ: 3.14 },
    ], ""),
    "Resolve": o([
        { json: "axis", js: "axis", typ: u(undefined, r("AxisResolveMap")) },
        { json: "legend", js: "legend", typ: u(undefined, r("LegendResolveMap")) },
        { json: "scale", js: "scale", typ: u(undefined, r("ScaleResolveMap")) },
    ], false),
    "AxisResolveMap": o([
        { json: "x", js: "x", typ: u(undefined, r("ResolveMode")) },
        { json: "y", js: "y", typ: u(undefined, r("ResolveMode")) },
    ], false),
    "LegendResolveMap": o([
        { json: "color", js: "color", typ: u(undefined, r("ResolveMode")) },
        { json: "opacity", js: "opacity", typ: u(undefined, r("ResolveMode")) },
        { json: "shape", js: "shape", typ: u(undefined, r("ResolveMode")) },
        { json: "size", js: "size", typ: u(undefined, r("ResolveMode")) },
    ], false),
    "ScaleResolveMap": o([
        { json: "color", js: "color", typ: u(undefined, r("ResolveMode")) },
        { json: "opacity", js: "opacity", typ: u(undefined, r("ResolveMode")) },
        { json: "shape", js: "shape", typ: u(undefined, r("ResolveMode")) },
        { json: "size", js: "size", typ: u(undefined, r("ResolveMode")) },
        { json: "x", js: "x", typ: u(undefined, r("ResolveMode")) },
        { json: "y", js: "y", typ: u(undefined, r("ResolveMode")) },
    ], false),
    "SelectionDef": o([
        { json: "bind", js: "bind", typ: u(undefined, u(r("BindEnum"), m(r("VGBinding")))) },
        { json: "empty", js: "empty", typ: u(undefined, r("Empty")) },
        { json: "encodings", js: "encodings", typ: u(undefined, a(r("SingleDefChannel"))) },
        { json: "fields", js: "fields", typ: u(undefined, a("")) },
        { json: "nearest", js: "nearest", typ: u(undefined, true) },
        { json: "on", js: "on", typ: u(undefined, "any") },
        { json: "resolve", js: "resolve", typ: u(undefined, r("SelectionResolution")) },
        { json: "type", js: "type", typ: r("SelectionDefType") },
        { json: "toggle", js: "toggle", typ: u(undefined, u(true, "")) },
        { json: "mark", js: "mark", typ: u(undefined, r("BrushConfig")) },
        { json: "translate", js: "translate", typ: u(undefined, u(true, "")) },
        { json: "zoom", js: "zoom", typ: u(undefined, u(true, "")) },
    ], false),
    "TitleParams": o([
        { json: "anchor", js: "anchor", typ: u(undefined, r("Anchor")) },
        { json: "offset", js: "offset", typ: u(undefined, 3.14) },
        { json: "orient", js: "orient", typ: u(undefined, r("TitleOrient")) },
        { json: "style", js: "style", typ: u(undefined, u(a(""), "")) },
        { json: "text", js: "text", typ: "" },
    ], false),
    "Transform": o([
        { json: "filter", js: "filter", typ: u(undefined, u(r("Predicate"), "")) },
        { json: "as", js: "as", typ: u(undefined, u(a(""), "")) },
        { json: "calculate", js: "calculate", typ: u(undefined, "") },
        { json: "default", js: "default", typ: u(undefined, "") },
        { json: "from", js: "from", typ: u(undefined, r("LookupData")) },
        { json: "lookup", js: "lookup", typ: u(undefined, "") },
        { json: "bin", js: "bin", typ: u(undefined, u(true, r("BinParams"))) },
        { json: "field", js: "field", typ: u(undefined, "") },
        { json: "timeUnit", js: "timeUnit", typ: u(undefined, r("TimeUnit")) },
        { json: "aggregate", js: "aggregate", typ: u(undefined, a(r("AggregatedFieldDef"))) },
        { json: "groupby", js: "groupby", typ: u(undefined, a("")) },
    ], false),
    "AggregatedFieldDef": o([
        { json: "as", js: "as", typ: "" },
        { json: "field", js: "field", typ: "" },
        { json: "op", js: "op", typ: r("AggregateOp") },
    ], false),
    "LookupData": o([
        { json: "data", js: "data", typ: r("Data") },
        { json: "fields", js: "fields", typ: u(undefined, a("")) },
        { json: "key", js: "key", typ: "" },
    ], false),
    "Repeat": o([
        { json: "column", js: "column", typ: u(undefined, a("")) },
        { json: "row", js: "row", typ: u(undefined, a("")) },
    ], false),
    "Contains": [
        "content",
        "padding",
    ],
    "AutosizeType": [
        "pad",
        "fit",
        "none",
    ],
    "HorizontalAlign": [
        "left",
        "right",
        "center",
    ],
    "VerticalAlign": [
        "top",
        "middle",
        "bottom",
    ],
    "Cursor": [
        "auto",
        "default",
        "none",
        "context-menu",
        "help",
        "pointer",
        "progress",
        "wait",
        "cell",
        "crosshair",
        "text",
        "vertical-text",
        "alias",
        "copy",
        "move",
        "no-drop",
        "not-allowed",
        "e-resize",
        "n-resize",
        "ne-resize",
        "nw-resize",
        "s-resize",
        "se-resize",
        "sw-resize",
        "w-resize",
        "ew-resize",
        "ns-resize",
        "nesw-resize",
        "nwse-resize",
        "col-resize",
        "row-resize",
        "all-scroll",
        "zoom-in",
        "zoom-out",
        "grab",
        "grabbing",
    ],
    "FontStyle": [
        "normal",
        "italic",
    ],
    "FontWeight": [
        "normal",
        "bold",
    ],
    "Interpolate": [
        "linear",
        "linear-closed",
        "step",
        "step-before",
        "step-after",
        "basis",
        "basis-open",
        "basis-closed",
        "cardinal",
        "cardinal-open",
        "cardinal-closed",
        "bundle",
        "monotone",
    ],
    "Orient": [
        "horizontal",
        "vertical",
    ],
    "LabelOverlapEnum": [
        "parity",
        "greedy",
    ],
    "FieldTitle": [
        "verbal",
        "functional",
        "plain",
    ],
    "InvalidValues": [
        "filter",
    ],
    "LegendOrient": [
        "left",
        "right",
        "top-left",
        "top-right",
        "bottom-left",
        "bottom-right",
        "none",
    ],
    "VGProjectionType": [
        "albers",
        "albersUsa",
        "azimuthalEqualArea",
        "azimuthalEquidistant",
        "conicConformal",
        "conicEqualArea",
        "conicEquidistant",
        "equirectangular",
        "gnomonic",
        "mercator",
        "orthographic",
        "stereographic",
        "transverseMercator",
    ],
    "BindEnum": [
        "scales",
    ],
    "Empty": [
        "all",
        "none",
    ],
    "SingleDefChannel": [
        "x",
        "y",
        "x2",
        "y2",
        "row",
        "column",
        "size",
        "shape",
        "color",
        "opacity",
        "text",
        "tooltip",
        "href",
    ],
    "SelectionResolution": [
        "global",
        "union",
        "intersect",
    ],
    "StackOffset": [
        "zero",
        "center",
        "normalize",
    ],
    "Anchor": [
        "start",
        "middle",
        "end",
    ],
    "TitleOrient": [
        "top",
        "bottom",
        "left",
        "right",
    ],
    "ParseEnum": [
        "auto",
    ],
    "DataFormatType": [
        "csv",
        "tsv",
        "json",
        "topojson",
    ],
    "AggregateOp": [
        "argmax",
        "argmin",
        "average",
        "count",
        "distinct",
        "max",
        "mean",
        "median",
        "min",
        "missing",
        "q1",
        "q3",
        "ci0",
        "ci1",
        "stdev",
        "stdevp",
        "sum",
        "valid",
        "values",
        "variance",
        "variancep",
    ],
    "TimeUnit": [
        "year",
        "quarter",
        "month",
        "day",
        "date",
        "hours",
        "minutes",
        "seconds",
        "milliseconds",
        "utcyear",
        "utcquarter",
        "utcmonth",
        "utcday",
        "utcdate",
        "utchours",
        "utcminutes",
        "utcseconds",
        "utcmilliseconds",
        "yearquarter",
        "yearquartermonth",
        "yearmonth",
        "yearmonthdate",
        "yearmonthdatehours",
        "yearmonthdatehoursminutes",
        "yearmonthdatehoursminutesseconds",
        "quartermonth",
        "monthdate",
        "hoursminutes",
        "hoursminutesseconds",
        "minutesseconds",
        "secondsmilliseconds",
        "utcyearquarter",
        "utcyearquartermonth",
        "utcyearmonth",
        "utcyearmonthdate",
        "utcyearmonthdatehours",
        "utcyearmonthdatehoursminutes",
        "utcyearmonthdatehoursminutesseconds",
        "utcquartermonth",
        "utcmonthdate",
        "utchoursminutes",
        "utchoursminutesseconds",
        "utcminutesseconds",
        "utcsecondsmilliseconds",
    ],
    "RepeatEnum": [
        "row",
        "column",
    ],
    "LegendType": [
        "symbol",
        "gradient",
    ],
    "Domain": [
        "unaggregated",
    ],
    "InterpolateParamsType": [
        "rgb",
        "cubehelix",
        "cubehelix-long",
    ],
    "NiceTime": [
        "second",
        "minute",
        "hour",
        "day",
        "week",
        "month",
        "year",
    ],
    "ScaleType": [
        "linear",
        "bin-linear",
        "log",
        "pow",
        "sqrt",
        "time",
        "utc",
        "sequential",
        "ordinal",
        "bin-ordinal",
        "point",
        "band",
    ],
    "SortEnum": [
        "ascending",
        "descending",
    ],
    "Type": [
        "quantitative",
        "ordinal",
        "temporal",
        "nominal",
        "latitude",
        "longitude",
        "geojson",
    ],
    "Mark": [
        "area",
        "bar",
        "line",
        "point",
        "text",
        "tick",
        "rect",
        "rule",
        "circle",
        "square",
        "geoshape",
    ],
    "ResolveMode": [
        "independent",
        "shared",
    ],
    "SelectionDefType": [
        "single",
        "multi",
        "interval",
    ],
};

module.exports = {
    "topLevelToJson": topLevelToJson,
    "toTopLevel": toTopLevel,
};

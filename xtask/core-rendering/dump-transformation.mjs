// The JSON dump of a `transformation` attribute, shared by
// record-render-cases.mjs and run-render-scenarios.mjs and rebuilt by
// crates/quicktype-core/tests/render_support. `typeRefIndex` is the function
// of the same name in quicktype-core's `Type/TypeRef.js`.

// A transformer tree (`Transformers.ts`) as JSON: `k` is the transformer's
// kind, `s` the index of its source type, and the other keys hold the
// kind-specific fields (child transformers are dumped the same way, absent
// ones as null):
//
//   decode, parse-string, stringify   { c: consumer }
//   string-producer                   { c, result }
//   min-max-length-check              { c, min, max }   (minLength, maxLength)
//   min-max-value-check               { c, min, max }   (minimum, maximum)
//   decode-array                      { c, item: itemTargetType, x: itemTransformer }
//   encode-array                      { item, x }
//   choice                            { xs: [transformer, ...] }
//   decoding-choice                   { null, integer, double, bool, string, array, object }
//   union-member-match                { x: transformer, member: memberType }
//   string-match                      { x: transformer, case: stringCase }
//   encode, union-instantiation       {}
export function dumpTransformer(xfer, typeRefIndex) {
    if (xfer === undefined) return null;
    const d = { k: xfer.kind, s: typeRefIndex(xfer.sourceTypeRef) };
    const bound = (n) => (n === undefined ? null : n);
    switch (xfer.kind) {
        case "decode":
        case "parse-string":
        case "stringify":
            d.c = dumpTransformer(xfer.consumer, typeRefIndex);
            break;
        case "string-producer":
            d.c = dumpTransformer(xfer.consumer, typeRefIndex);
            d.result = xfer.result;
            break;
        case "min-max-length-check":
            d.c = dumpTransformer(xfer.consumer, typeRefIndex);
            d.min = bound(xfer.minLength);
            d.max = bound(xfer.maxLength);
            break;
        case "min-max-value-check":
            d.c = dumpTransformer(xfer.consumer, typeRefIndex);
            d.min = bound(xfer.minimum);
            d.max = bound(xfer.maximum);
            break;
        case "decode-array":
            d.c = dumpTransformer(xfer.consumer, typeRefIndex);
            d.item = typeRefIndex(xfer._itemTargetTypeRef);
            d.x = dumpTransformer(xfer.itemTransformer, typeRefIndex);
            break;
        case "encode-array":
            d.item = typeRefIndex(xfer._itemTargetTypeRef);
            d.x = dumpTransformer(xfer.itemTransformer, typeRefIndex);
            break;
        case "choice":
            d.xs = xfer.transformers.map((x) => dumpTransformer(x, typeRefIndex));
            break;
        case "decoding-choice":
            d.null = dumpTransformer(xfer.nullTransformer, typeRefIndex);
            d.integer = dumpTransformer(xfer.integerTransformer, typeRefIndex);
            d.double = dumpTransformer(xfer.doubleTransformer, typeRefIndex);
            d.bool = dumpTransformer(xfer.boolTransformer, typeRefIndex);
            d.string = dumpTransformer(xfer.stringTransformer, typeRefIndex);
            d.array = dumpTransformer(xfer.arrayTransformer, typeRefIndex);
            d.object = dumpTransformer(xfer.objectTransformer, typeRefIndex);
            break;
        case "union-member-match":
            d.x = dumpTransformer(xfer.transformer, typeRefIndex);
            d.member = typeRefIndex(xfer.memberTypeRef);
            break;
        case "string-match":
            d.x = dumpTransformer(xfer.transformer, typeRefIndex);
            d.case = xfer.stringCase;
            break;
        case "encode":
        case "union-instantiation":
            break;
        default:
            throw new Error(`cannot dump transformer ${xfer.kind}`);
    }
    return d;
}

// A Transformation: the index of its target type and its transformer tree.
export function dumpTransformation(transformation, typeRefIndex) {
    return {
        target: typeRefIndex(transformation._targetTypeRef),
        xfer: dumpTransformer(transformation.transformer, typeRefIndex),
    };
}

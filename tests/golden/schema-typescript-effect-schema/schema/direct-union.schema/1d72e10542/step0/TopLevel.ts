import * as S from "effect/Schema";


export class TextNode extends S.Class<TextNode>("TextNode")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class Thing extends S.Class<Thing>("Thing")({
    "optional": S.optional(S.Union(S.Array(S.Any), S.Boolean, S.Number, S.Int, S.Record({ key: S.String, value: S.Any}), S.String, S.Null)),
    "required": S.Union(S.Array(S.Any), S.Boolean, S.Number, S.Int, S.Record({ key: S.String, value: S.Any}), S.String, S.Null),
}) {}

export class ObjectNode extends S.Class<ObjectNode>("ObjectNode")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class NullNode extends S.Class<NullNode>("NullNode")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class LongNode extends S.Class<LongNode>("LongNode")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class IntNode extends S.Class<IntNode>("IntNode")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class DoubleNode extends S.Class<DoubleNode>("DoubleNode")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class BooleanNode extends S.Class<BooleanNode>("BooleanNode")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class ArrayNode extends S.Class<ArrayNode>("ArrayNode")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "arrayNode": S.optional(ArrayNode),
    "booleanNode": S.optional(BooleanNode),
    "doubleNode": S.optional(DoubleNode),
    "intNode": S.optional(IntNode),
    "longNode": S.optional(LongNode),
    "nullNode": S.optional(NullNode),
    "objectNode": S.optional(ObjectNode),
    "stuff": S.Record({ key: S.String, value: Thing}),
    "textNode": S.optional(TextNode),
}) {}

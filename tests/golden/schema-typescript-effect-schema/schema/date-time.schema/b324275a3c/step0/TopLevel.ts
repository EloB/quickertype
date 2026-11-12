import * as S from "effect/Schema";


export const ComplexUnionArrayEnum = S.Literal(
    "foo",
    "bar",
);
export type ComplexUnionArrayEnum = S.Schema.Type<typeof ComplexUnionArrayEnum>;

export class OffsetTime extends S.Class<OffsetTime>("OffsetTime")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class OffsetDateTime extends S.Class<OffsetDateTime>("OffsetDateTime")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class LocalDate extends S.Class<LocalDate>("LocalDate")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "complex-union-array": S.Array(S.Union(S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)), ComplexUnionArrayEnum, S.Int)),
    "date": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)),
    "date-time": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "local-date-class": S.optional(LocalDate),
    "offset-date-time-class": S.optional(OffsetDateTime),
    "offset-time-class": S.optional(OffsetTime),
    "time": S.String.pipe(S.pattern(/^\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)),
    "union-array": S.Array(S.Union(S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)), S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)), S.String.pipe(S.pattern(/^\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)))),
}) {}

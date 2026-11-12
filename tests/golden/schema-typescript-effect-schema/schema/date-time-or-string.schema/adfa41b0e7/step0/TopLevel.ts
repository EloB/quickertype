import * as S from "effect/Schema";


export const BarEnum = S.Literal(
    "quux",
);
export type BarEnum = S.Schema.Type<typeof BarEnum>;

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "bar": S.Union(S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/)), BarEnum),
    "foo": S.String,
}) {}

import * as S from "effect/Schema";


export const Health = S.Literal(
    "ok",
    "error",
);
export type Health = S.Schema.Type<typeof Health>;

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "health": Health,
}) {}

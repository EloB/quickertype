import * as S from "effect/Schema";


export const Shortcut = S.Literal(
    "hidden",
    "visible",
);
export type Shortcut = S.Schema.Type<typeof Shortcut>;

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "name": S.String,
    "shortcut": S.optional(Shortcut),
}) {}

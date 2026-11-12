import * as S from "effect/Schema";


export const TopLevel = S.Literal(
    "one",
    "three",
    "two",
);
export type TopLevel = S.Schema.Type<typeof TopLevel>;

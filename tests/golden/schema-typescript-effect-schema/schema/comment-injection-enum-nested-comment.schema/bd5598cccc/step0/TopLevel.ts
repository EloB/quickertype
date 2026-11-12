import * as S from "effect/Schema";

// Nested enum block comment openers:
// {-
// /*
// This text must remain inside the generated enum documentation comment.

export const Kind = S.Literal(
    "ok",
);
export type Kind = S.Schema.Type<typeof Kind>;

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "kind": Kind,
}) {}

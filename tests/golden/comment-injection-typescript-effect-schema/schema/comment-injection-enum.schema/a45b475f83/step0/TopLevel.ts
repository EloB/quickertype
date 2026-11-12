import * as S from "effect/Schema";

// Comment delimiters:
// */
// {-
// -}
// """
// }
// }

export const Kind = S.Literal(
    "ok",
);
export type Kind = S.Schema.Type<typeof Kind>;

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "kind": Kind,
}) {}

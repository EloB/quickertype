import * as S from "effect/Schema";


export class TextClassificationOutputElement extends S.Class<TextClassificationOutputElement>("TextClassificationOutputElement")({
    "label": S.String,
    "score": S.Number,
}) {}

export const TopLevel = S.Array(TextClassificationOutputElement);
export type TopLevel = S.Schema.Type<typeof TopLevel>;

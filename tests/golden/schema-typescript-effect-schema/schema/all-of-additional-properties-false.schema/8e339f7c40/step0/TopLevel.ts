import * as S from "effect/Schema";


export const Frequency = S.Literal(
    "Weekly",
    "Monthly",
    "Annually",
);
export type Frequency = S.Schema.Type<typeof Frequency>;


export const Type = S.Literal(
    "GrossSalaryAmount",
    "Overtime",
);
export type Type = S.Schema.Type<typeof Type>;

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "amount": S.Number,
    "frequency": Frequency,
    "description": S.optional(S.String),
    "type": Type,
}) {}

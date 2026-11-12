import * as S from "effect/Schema";


export const Weekdays = S.Literal(
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
);
export type Weekdays = S.Schema.Type<typeof Weekdays>;

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "weekdays": Weekdays,
}) {}

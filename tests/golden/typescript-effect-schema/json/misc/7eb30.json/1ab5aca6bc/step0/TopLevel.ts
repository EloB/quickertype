import * as S from "effect/Schema";


export const Code = S.Literal(
    "sf",
);
export type Code = S.Schema.Type<typeof Code>;


export const English = S.Literal(
    "SF",
);
export type English = S.Schema.Type<typeof English>;


export const Thai = S.Literal(
    "เอสเอฟ",
);
export type Thai = S.Schema.Type<typeof Thai>;


export const Location = S.Literal(
    "",
    "5th Fl. Emporium",
);
export type Location = S.Schema.Type<typeof Location>;


export const Tel = S.Literal(
    "",
    "02-268-8899",
);
export type Tel = S.Schema.Type<typeof Tel>;

export class Group extends S.Class<Group>("Group")({
    "code": Code,
    "english": English,
    "thai": Thai,
    "website": S.String,
}) {}

export class Result extends S.Class<Result>("Result")({
    "code": S.String.pipe(S.pattern(/^-?\d+$/)),
    "english": S.String,
    "fav": S.Boolean,
    "group": Group,
    "location": Location,
    "min_screens": S.Int,
    "num_views": S.Int,
    "showtimes": S.String,
    "stars": S.Int,
    "tel": Tel,
    "thai": S.String,
    "today_screens": S.Int,
    "url": S.String,
    "website": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "count": S.Int,
    "next": S.String,
    "previous": S.Null,
    "results": S.Array(Result),
}) {}

import * as S from "effect/Schema";


export const Id = S.Literal(
    "",
    "SAS",
    "SSA",
    "ECA",
    "LAC",
    "EAP",
    "MNA",
    "HIC",
    "LIC",
    "NA",
    "LMC",
    "UMC",
    "LNX",
    "IDX",
    "IBD",
    "IDB",
    "LCN",
    "SSF",
    "ECS",
    "MEA",
    "EAS",
    "NAC",
);
export type Id = S.Schema.Type<typeof Id>;


export const Value = S.Literal(
    "",
    "South Asia",
    "Sub-Saharan Africa (excluding high income)",
    "Europe & Central Asia (excluding high income)",
    "Latin America & Caribbean (excluding high income)",
    "East Asia & Pacific (excluding high income)",
    "Middle East & North Africa (excluding high income)",
    "High income",
    "Low income",
    "Aggregates",
    "Lower middle income",
    "Upper middle income",
    "Not classified",
    "IDA",
    "IBRD",
    "Blend",
    "Latin America & Caribbean ",
    "Sub-Saharan Africa ",
    "Europe & Central Asia",
    "Middle East & North Africa",
    "East Asia & Pacific",
    "North America",
);
export type Value = S.Schema.Type<typeof Value>;

export class FluffyTopLevel extends S.Class<FluffyTopLevel>("FluffyTopLevel")({
    "page": S.Int,
    "pages": S.Int,
    "per_page": S.String.pipe(S.pattern(/^-?\d+$/)),
    "total": S.Int,
}) {}

export class Adminregion extends S.Class<Adminregion>("Adminregion")({
    "id": Id,
    "value": Value,
}) {}

export class PurpleTopLevel extends S.Class<PurpleTopLevel>("PurpleTopLevel")({
    "adminregion": Adminregion,
    "capitalCity": S.String,
    "id": S.String,
    "incomeLevel": Adminregion,
    "iso2Code": S.String,
    "latitude": S.String,
    "lendingType": Adminregion,
    "longitude": S.String,
    "name": S.String,
    "region": Adminregion,
}) {}

export const TopLevel = S.Array(S.Union(S.Array(PurpleTopLevel), FluffyTopLevel));
export type TopLevel = S.Schema.Type<typeof TopLevel>;

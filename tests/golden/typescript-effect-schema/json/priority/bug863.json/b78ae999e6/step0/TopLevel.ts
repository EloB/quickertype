import * as S from "effect/Schema";


export const Breed = S.Literal(
    "Atrox",
    "Solitus",
    "Opifex",
    "Nano",
);
export type Breed = S.Schema.Type<typeof Breed>;


export const Firstname = S.Literal(
    "",
    "Chi",
);
export type Firstname = S.Schema.Type<typeof Firstname>;


export const Lastname = S.Literal(
    "",
    "Washko",
);
export type Lastname = S.Schema.Type<typeof Lastname>;


export const Pvptitle = S.Literal(
    "Freshman",
);
export type Pvptitle = S.Schema.Type<typeof Pvptitle>;


export const RankTitle = S.Literal(
    "President",
    "Advisor",
    "Veteran",
    "Applicant",
);
export type RankTitle = S.Schema.Type<typeof RankTitle>;


export const Sex = S.Literal(
    "Neuter",
    "Male",
    "Female",
);
export type Sex = S.Schema.Type<typeof Sex>;

export class FluffyTopLevel extends S.Class<FluffyTopLevel>("FluffyTopLevel")({
    "ADVENTURERCOUNT": S.Int,
    "AGENTCOUNT": S.Int,
    "ATROXCOUNT": S.Int,
    "AVGLVL": S.Number,
    "BTCOUNT": S.Int,
    "DESCRIPTION": S.String,
    "DOCTORCOUNT": S.Int,
    "ENFCOUNT": S.Int,
    "ENGINEEERCOUNT": S.Int,
    "FEMALECOUNT": S.Int,
    "FIXERCOUNT": S.Int,
    "GOVERNINGNAME": S.String,
    "HISTORY": S.String,
    "KEEPERCOUNT": S.Int,
    "MACOUNT": S.Int,
    "MALECOUNT": S.Int,
    "MAXLVL": S.Int,
    "METACOUNT": S.Int,
    "MINLVL": S.Int,
    "MONSTERCOUNT": S.Int,
    "NAME": S.String,
    "NANOCOUNT": S.Int,
    "NANORACECOUNT": S.Int,
    "NEUTERCOUNT": S.Int,
    "NUMMEMBERS": S.Int,
    "OBJECTIVE": S.String,
    "OPIFEXCOUNT": S.Int,
    "ORG_DIMENSION": S.Int,
    "ORG_INSTANCE": S.Int,
    "SHADECOUNT": S.Int,
    "SIDE": S.Int,
    "SIDE_NAME": S.String,
    "SOLIDERCOUNT": S.Int,
    "SOLITUSCOUNT": S.Int,
    "TRADERCOUNT": S.Int,
}) {}

export class PurpleTopLevel extends S.Class<PurpleTopLevel>("PurpleTopLevel")({
    "ALIENLEVEL": S.Int,
    "BREED": Breed,
    "CHAR_DIMENSION": S.Int,
    "CHAR_INSTANCE": S.Int,
    "DEFENDER_RANK_TITLE": S.String,
    "FIRSTNAME": Firstname,
    "HEADID": S.Int,
    "LASTNAME": Lastname,
    "LEVELX": S.Int,
    "NAME": S.String,
    "PROF": S.String,
    "PROF_TITLE": S.String,
    "PVPRATING": S.Int,
    "PVPTITLE": Pvptitle,
    "RANK": S.Int,
    "RANK_TITLE": RankTitle,
    "SEX": Sex,
}) {}

export const TopLevel = S.Array(S.Union(S.Array(PurpleTopLevel), S.String, FluffyTopLevel));
export type TopLevel = S.Schema.Type<typeof TopLevel>;

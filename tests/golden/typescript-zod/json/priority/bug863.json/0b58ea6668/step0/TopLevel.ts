import * as z from "zod";


export const BreedSchema = z.enum([
    "Atrox",
    "Solitus",
    "Opifex",
    "Nano",
]);
export type Breed = z.infer<typeof BreedSchema>;


export const FirstnameSchema = z.enum([
    "",
    "Chi",
]);
export type Firstname = z.infer<typeof FirstnameSchema>;


export const LastnameSchema = z.enum([
    "",
    "Washko",
]);
export type Lastname = z.infer<typeof LastnameSchema>;


export const PvptitleSchema = z.enum([
    "Freshman",
]);
export type Pvptitle = z.infer<typeof PvptitleSchema>;


export const RankTitleSchema = z.enum([
    "President",
    "Advisor",
    "Veteran",
    "Applicant",
]);
export type RankTitle = z.infer<typeof RankTitleSchema>;


export const SexSchema = z.enum([
    "Neuter",
    "Male",
    "Female",
]);
export type Sex = z.infer<typeof SexSchema>;

export const PurpleTopLevelSchema = z.object({
    "ALIENLEVEL": z.number().int(),
    "BREED": BreedSchema,
    "CHAR_DIMENSION": z.number().int(),
    "CHAR_INSTANCE": z.number().int(),
    "DEFENDER_RANK_TITLE": z.string(),
    "FIRSTNAME": FirstnameSchema,
    "HEADID": z.number().int(),
    "LASTNAME": LastnameSchema,
    "LEVELX": z.number().int(),
    "NAME": z.string(),
    "PROF": z.string(),
    "PROF_TITLE": z.string(),
    "PVPRATING": z.number().int(),
    "PVPTITLE": PvptitleSchema,
    "RANK": z.number().int(),
    "RANK_TITLE": RankTitleSchema,
    "SEX": SexSchema,
});
export type PurpleTopLevel = z.infer<typeof PurpleTopLevelSchema>;

export const FluffyTopLevelSchema = z.object({
    "ADVENTURERCOUNT": z.number().int(),
    "AGENTCOUNT": z.number().int(),
    "ATROXCOUNT": z.number().int(),
    "AVGLVL": z.number(),
    "BTCOUNT": z.number().int(),
    "DESCRIPTION": z.string(),
    "DOCTORCOUNT": z.number().int(),
    "ENFCOUNT": z.number().int(),
    "ENGINEEERCOUNT": z.number().int(),
    "FEMALECOUNT": z.number().int(),
    "FIXERCOUNT": z.number().int(),
    "GOVERNINGNAME": z.string(),
    "HISTORY": z.string(),
    "KEEPERCOUNT": z.number().int(),
    "MACOUNT": z.number().int(),
    "MALECOUNT": z.number().int(),
    "MAXLVL": z.number().int(),
    "METACOUNT": z.number().int(),
    "MINLVL": z.number().int(),
    "MONSTERCOUNT": z.number().int(),
    "NAME": z.string(),
    "NANOCOUNT": z.number().int(),
    "NANORACECOUNT": z.number().int(),
    "NEUTERCOUNT": z.number().int(),
    "NUMMEMBERS": z.number().int(),
    "OBJECTIVE": z.string(),
    "OPIFEXCOUNT": z.number().int(),
    "ORG_DIMENSION": z.number().int(),
    "ORG_INSTANCE": z.number().int(),
    "SHADECOUNT": z.number().int(),
    "SIDE": z.number().int(),
    "SIDE_NAME": z.string(),
    "SOLIDERCOUNT": z.number().int(),
    "SOLITUSCOUNT": z.number().int(),
    "TRADERCOUNT": z.number().int(),
});
export type FluffyTopLevel = z.infer<typeof FluffyTopLevelSchema>;

export const TopLevelSchema = z.array(z.union([z.array(PurpleTopLevelSchema), FluffyTopLevelSchema, z.string()]));
export type TopLevel = z.infer<typeof TopLevelSchema>;

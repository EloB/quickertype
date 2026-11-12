import * as z from "zod";


export const IdSchema = z.enum([
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
]);
export type Id = z.infer<typeof IdSchema>;


export const ValueSchema = z.enum([
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
]);
export type Value = z.infer<typeof ValueSchema>;

export const AdminregionSchema = z.object({
    "id": IdSchema,
    "value": ValueSchema,
});
export type Adminregion = z.infer<typeof AdminregionSchema>;

export const FluffyTopLevelSchema = z.object({
    "page": z.number().int(),
    "pages": z.number().int(),
    "per_page": z.string().regex(/^-?\d+$/),
    "total": z.number().int(),
});
export type FluffyTopLevel = z.infer<typeof FluffyTopLevelSchema>;

export const PurpleTopLevelSchema = z.object({
    "adminregion": AdminregionSchema,
    "capitalCity": z.string(),
    "id": z.string(),
    "incomeLevel": AdminregionSchema,
    "iso2Code": z.string(),
    "latitude": z.string(),
    "lendingType": AdminregionSchema,
    "longitude": z.string(),
    "name": z.string(),
    "region": AdminregionSchema,
});
export type PurpleTopLevel = z.infer<typeof PurpleTopLevelSchema>;

export const TopLevelSchema = z.array(z.union([z.array(PurpleTopLevelSchema), FluffyTopLevelSchema]));
export type TopLevel = z.infer<typeof TopLevelSchema>;

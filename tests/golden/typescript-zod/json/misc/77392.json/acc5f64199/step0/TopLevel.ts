import * as z from "zod";


export const OrbitClassSchema = z.enum([
    "Apollo",
    "Amor",
    "Aten",
    "Comet",
    "Jupiter-family Comet",
    "Halley-type Comet*",
    "Parabolic Comet",
    "Jupiter-family Comet*",
    "Encke-type Comet",
]);
export type OrbitClass = z.infer<typeof OrbitClassSchema>;


export const PhaSchema = z.enum([
    "Y",
    "N",
    "n/a",
]);
export type Pha = z.infer<typeof PhaSchema>;

export const TopLevelElementSchema = z.object({
    "designation": z.string(),
    "discovery_date": z.string().pipe(z.coerce.date()),
    "h_mag": z.string().optional(),
    "i_deg": z.string(),
    "moid_au": z.string(),
    "orbit_class": OrbitClassSchema,
    "period_yr": z.string().optional(),
    "pha": PhaSchema,
    "q_au_1": z.string(),
    "q_au_2": z.string().optional(),
});
export type TopLevelElement = z.infer<typeof TopLevelElementSchema>;

export const TopLevelSchema = z.array(TopLevelElementSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;

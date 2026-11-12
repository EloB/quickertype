import * as z from "zod";


export const EggSchema = z.enum([
    "2 km",
    "Not in Eggs",
    "5 km",
    "10 km",
    "Omanyte Candy",
]);
export type Egg = z.infer<typeof EggSchema>;


export const TypeSchema = z.enum([
    "Fire",
    "Ice",
    "Flying",
    "Psychic",
    "Water",
    "Ground",
    "Rock",
    "Electric",
    "Grass",
    "Fighting",
    "Poison",
    "Bug",
    "Fairy",
    "Ghost",
    "Dark",
    "Steel",
    "Dragon",
    "Normal",
]);
export type Type = z.infer<typeof TypeSchema>;

export const EvolutionSchema = z.object({
    "name": z.string(),
    "num": z.string(),
});
export type Evolution = z.infer<typeof EvolutionSchema>;

export const PokemonSchema = z.object({
    "avg_spawns": z.number(),
    "candy": z.string(),
    "candy_count": z.number().int().optional(),
    "egg": EggSchema,
    "height": z.string(),
    "id": z.number().int(),
    "img": z.string(),
    "multipliers": z.union([z.null(), z.array(z.number())]),
    "name": z.string(),
    "next_evolution": z.array(EvolutionSchema).optional(),
    "num": z.string(),
    "prev_evolution": z.array(EvolutionSchema).optional(),
    "spawn_chance": z.number(),
    "spawn_time": z.string(),
    "type": z.array(TypeSchema),
    "weaknesses": z.array(TypeSchema),
    "weight": z.string(),
});
export type Pokemon = z.infer<typeof PokemonSchema>;

export const TopLevelSchema = z.object({
    "pokemon": z.array(PokemonSchema),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;

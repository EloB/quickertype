import * as S from "effect/Schema";


export const Egg = S.Literal(
    "2 km",
    "Not in Eggs",
    "5 km",
    "10 km",
    "Omanyte Candy",
);
export type Egg = S.Schema.Type<typeof Egg>;


export const Type = S.Literal(
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
);
export type Type = S.Schema.Type<typeof Type>;

export class Evolution extends S.Class<Evolution>("Evolution")({
    "name": S.String,
    "num": S.String,
}) {}

export class Pokemon extends S.Class<Pokemon>("Pokemon")({
    "avg_spawns": S.Number,
    "candy": S.String,
    "candy_count": S.optional(S.Int),
    "egg": Egg,
    "height": S.String,
    "id": S.Int,
    "img": S.String,
    "multipliers": S.NullOr(S.Array(S.Number)),
    "name": S.String,
    "next_evolution": S.optional(S.Array(Evolution)),
    "num": S.String,
    "prev_evolution": S.optional(S.Array(Evolution)),
    "spawn_chance": S.Number,
    "spawn_time": S.String,
    "type": S.Array(Type),
    "weaknesses": S.Array(Type),
    "weight": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "pokemon": S.Array(Pokemon),
}) {}

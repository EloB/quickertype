// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<Pokemon> pokemon;

    TopLevel({
        required this.pokemon,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        pokemon: List<Pokemon>.from(json["pokemon"].map((x) => Pokemon.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "pokemon": List<dynamic>.from(pokemon.map((x) => x.toJson())),
    };
}

class Pokemon {
    final double avgSpawns;
    final String candy;
    final int? candyCount;
    final Egg egg;
    final String height;
    final int id;
    final String img;
    final List<double>? multipliers;
    final String name;
    final List<Evolution>? nextEvolution;
    final String num;
    final List<Evolution>? prevEvolution;
    final double spawnChance;
    final String spawnTime;
    final List<Type> type;
    final List<Type> weaknesses;
    final String weight;

    Pokemon({
        required this.avgSpawns,
        required this.candy,
        this.candyCount,
        required this.egg,
        required this.height,
        required this.id,
        required this.img,
        required this.multipliers,
        required this.name,
        this.nextEvolution,
        required this.num,
        this.prevEvolution,
        required this.spawnChance,
        required this.spawnTime,
        required this.type,
        required this.weaknesses,
        required this.weight,
    });

    factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        avgSpawns: json["avg_spawns"]?.toDouble(),
        candy: json["candy"],
        candyCount: json["candy_count"],
        egg: eggValues.map[json["egg"]]!,
        height: json["height"],
        id: json["id"],
        img: json["img"],
        multipliers: (json.containsKey("multipliers") ? json["multipliers"] : throw FormatException('Missing required property')) == null ? null : List<double>.from((json.containsKey("multipliers") ? json["multipliers"] : throw FormatException('Missing required property'))!.map((x) => x?.toDouble())),
        name: json["name"],
        nextEvolution: json["next_evolution"] == null ? null : List<Evolution>.from(json["next_evolution"]!.map((x) => Evolution.fromJson(x))),
        num: json["num"],
        prevEvolution: json["prev_evolution"] == null ? null : List<Evolution>.from(json["prev_evolution"]!.map((x) => Evolution.fromJson(x))),
        spawnChance: json["spawn_chance"]?.toDouble(),
        spawnTime: json["spawn_time"],
        type: List<Type>.from(json["type"].map((x) => typeValues.map[x]!)),
        weaknesses: List<Type>.from(json["weaknesses"].map((x) => typeValues.map[x]!)),
        weight: json["weight"],
    );

    Map<String, dynamic> toJson() => {
        "avg_spawns": avgSpawns,
        "candy": candy,
        "candy_count": candyCount,
        "egg": eggValues.reverse[egg],
        "height": height,
        "id": id,
        "img": img,
        "multipliers": multipliers == null ? null : List<dynamic>.from(multipliers!.map((x) => x)),
        "name": name,
        "next_evolution": nextEvolution == null ? null : List<dynamic>.from(nextEvolution!.map((x) => x.toJson())),
        "num": num,
        "prev_evolution": prevEvolution == null ? null : List<dynamic>.from(prevEvolution!.map((x) => x.toJson())),
        "spawn_chance": spawnChance,
        "spawn_time": spawnTime,
        "type": List<dynamic>.from(type.map((x) => typeValues.reverse[x])),
        "weaknesses": List<dynamic>.from(weaknesses.map((x) => typeValues.reverse[x])),
        "weight": weight,
    };
}

enum Egg {
    THE_2_KM,
    NOT_IN_EGGS,
    THE_5_KM,
    THE_10_KM,
    OMANYTE_CANDY
}

final eggValues = EnumValues({
    "2 km": Egg.THE_2_KM,
    "Not in Eggs": Egg.NOT_IN_EGGS,
    "5 km": Egg.THE_5_KM,
    "10 km": Egg.THE_10_KM,
    "Omanyte Candy": Egg.OMANYTE_CANDY
});

class Evolution {
    final String name;
    final String num;

    Evolution({
        required this.name,
        required this.num,
    });

    factory Evolution.fromJson(Map<String, dynamic> json) => Evolution(
        name: json["name"],
        num: json["num"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "num": num,
    };
}

enum Type {
    FIRE,
    ICE,
    FLYING,
    PSYCHIC,
    WATER,
    GROUND,
    ROCK,
    ELECTRIC,
    GRASS,
    FIGHTING,
    POISON,
    BUG,
    FAIRY,
    GHOST,
    DARK,
    STEEL,
    DRAGON,
    NORMAL
}

final typeValues = EnumValues({
    "Fire": Type.FIRE,
    "Ice": Type.ICE,
    "Flying": Type.FLYING,
    "Psychic": Type.PSYCHIC,
    "Water": Type.WATER,
    "Ground": Type.GROUND,
    "Rock": Type.ROCK,
    "Electric": Type.ELECTRIC,
    "Grass": Type.GRASS,
    "Fighting": Type.FIGHTING,
    "Poison": Type.POISON,
    "Bug": Type.BUG,
    "Fairy": Type.FAIRY,
    "Ghost": Type.GHOST,
    "Dark": Type.DARK,
    "Steel": Type.STEEL,
    "Dragon": Type.DRAGON,
    "Normal": Type.NORMAL
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}

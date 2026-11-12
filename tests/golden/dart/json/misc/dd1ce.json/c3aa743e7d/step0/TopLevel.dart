// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<Booster> booster;
    final String border;
    final List<Card> cards;
    final String code;
    final String gathererCode;
    final String magicCardsInfoCode;
    final int mkmId;
    final String mkmName;
    final String name;
    final DateTime releaseDate;
    final String type;

    TopLevel({
        required this.booster,
        required this.border,
        required this.cards,
        required this.code,
        required this.gathererCode,
        required this.magicCardsInfoCode,
        required this.mkmId,
        required this.mkmName,
        required this.name,
        required this.releaseDate,
        required this.type,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        booster: List<Booster>.from(json["booster"].map((x) => boosterValues.map[x]!)),
        border: json["border"],
        cards: List<Card>.from(json["cards"].map((x) => Card.fromJson(x))),
        code: json["code"],
        gathererCode: json["gathererCode"],
        magicCardsInfoCode: json["magicCardsInfoCode"],
        mkmId: json["mkm_id"],
        mkmName: json["mkm_name"],
        name: json["name"],
        releaseDate: DateTime.parse(json["releaseDate"]),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "booster": List<dynamic>.from(booster.map((x) => boosterValues.reverse[x])),
        "border": border,
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
        "code": code,
        "gathererCode": gathererCode,
        "magicCardsInfoCode": magicCardsInfoCode,
        "mkm_id": mkmId,
        "mkm_name": mkmName,
        "name": name,
        "releaseDate": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "type": type,
    };
}

enum Booster {
    RARE,
    UNCOMMON,
    COMMON
}

final boosterValues = EnumValues({
    "rare": Booster.RARE,
    "uncommon": Booster.UNCOMMON,
    "common": Booster.COMMON
});

class Card {
    final String artist;
    final int cmc;
    final List<ColorIdentity>? colorIdentity;
    final List<Color>? colors;
    final String? flavor;
    final String id;
    final String imageName;
    final Layout layout;
    final List<LegalityElement> legalities;
    final String? manaCost;
    final String? mciNumber;
    final int multiverseid;
    final String name;
    final String? originalText;
    final String originalType;
    final String? power;
    final List<String> printings;
    final Rarity rarity;
    final bool? reserved;
    final List<Ruling>? rulings;
    final List<String>? subtypes;
    final List<Supertype>? supertypes;
    final String? text;
    final String? toughness;
    final String type;
    final List<Type> types;
    final List<int>? variations;

    Card({
        required this.artist,
        required this.cmc,
        this.colorIdentity,
        this.colors,
        this.flavor,
        required this.id,
        required this.imageName,
        required this.layout,
        required this.legalities,
        this.manaCost,
        this.mciNumber,
        required this.multiverseid,
        required this.name,
        this.originalText,
        required this.originalType,
        this.power,
        required this.printings,
        required this.rarity,
        this.reserved,
        this.rulings,
        this.subtypes,
        this.supertypes,
        this.text,
        this.toughness,
        required this.type,
        required this.types,
        this.variations,
    });

    factory Card.fromJson(Map<String, dynamic> json) => Card(
        artist: json["artist"],
        cmc: json["cmc"],
        colorIdentity: json["colorIdentity"] == null ? null : List<ColorIdentity>.from(json["colorIdentity"]!.map((x) => colorIdentityValues.map[x]!)),
        colors: json["colors"] == null ? null : List<Color>.from(json["colors"]!.map((x) => colorValues.map[x]!)),
        flavor: json["flavor"],
        id: json["id"],
        imageName: json["imageName"],
        layout: layoutValues.map[json["layout"]]!,
        legalities: List<LegalityElement>.from(json["legalities"].map((x) => LegalityElement.fromJson(x))),
        manaCost: json["manaCost"],
        mciNumber: json["mciNumber"],
        multiverseid: json["multiverseid"],
        name: json["name"],
        originalText: json["originalText"],
        originalType: json["originalType"],
        power: json["power"],
        printings: List<String>.from(json["printings"].map((x) => x)),
        rarity: rarityValues.map[json["rarity"]]!,
        reserved: json["reserved"],
        rulings: json["rulings"] == null ? null : List<Ruling>.from(json["rulings"]!.map((x) => Ruling.fromJson(x))),
        subtypes: json["subtypes"] == null ? null : List<String>.from(json["subtypes"]!.map((x) => x)),
        supertypes: json["supertypes"] == null ? null : List<Supertype>.from(json["supertypes"]!.map((x) => supertypeValues.map[x]!)),
        text: json["text"],
        toughness: json["toughness"],
        type: json["type"],
        types: List<Type>.from(json["types"].map((x) => typeValues.map[x]!)),
        variations: json["variations"] == null ? null : List<int>.from(json["variations"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "artist": artist,
        "cmc": cmc,
        "colorIdentity": colorIdentity == null ? null : List<dynamic>.from(colorIdentity!.map((x) => colorIdentityValues.reverse[x])),
        "colors": colors == null ? null : List<dynamic>.from(colors!.map((x) => colorValues.reverse[x])),
        "flavor": flavor,
        "id": id,
        "imageName": imageName,
        "layout": layoutValues.reverse[layout],
        "legalities": List<dynamic>.from(legalities.map((x) => x.toJson())),
        "manaCost": manaCost,
        "mciNumber": mciNumber,
        "multiverseid": multiverseid,
        "name": name,
        "originalText": originalText,
        "originalType": originalType,
        "power": power,
        "printings": List<dynamic>.from(printings.map((x) => x)),
        "rarity": rarityValues.reverse[rarity],
        "reserved": reserved,
        "rulings": rulings == null ? null : List<dynamic>.from(rulings!.map((x) => x.toJson())),
        "subtypes": subtypes == null ? null : List<dynamic>.from(subtypes!.map((x) => x)),
        "supertypes": supertypes == null ? null : List<dynamic>.from(supertypes!.map((x) => supertypeValues.reverse[x])),
        "text": text,
        "toughness": toughness,
        "type": type,
        "types": List<dynamic>.from(types.map((x) => typeValues.reverse[x])),
        "variations": variations == null ? null : List<dynamic>.from(variations!.map((x) => x)),
    };
}

enum ColorIdentity {
    U,
    B,
    W,
    G,
    R
}

final colorIdentityValues = EnumValues({
    "U": ColorIdentity.U,
    "B": ColorIdentity.B,
    "W": ColorIdentity.W,
    "G": ColorIdentity.G,
    "R": ColorIdentity.R
});

enum Color {
    BLUE,
    BLACK,
    WHITE,
    GREEN,
    RED
}

final colorValues = EnumValues({
    "Blue": Color.BLUE,
    "Black": Color.BLACK,
    "White": Color.WHITE,
    "Green": Color.GREEN,
    "Red": Color.RED
});

enum Layout {
    NORMAL
}

final layoutValues = EnumValues({
    "normal": Layout.NORMAL
});

class LegalityElement {
    final Format format;
    final LegalityEnum legality;

    LegalityElement({
        required this.format,
        required this.legality,
    });

    factory LegalityElement.fromJson(Map<String, dynamic> json) => LegalityElement(
        format: formatValues.map[json["format"]]!,
        legality: legalityEnumValues.map[json["legality"]]!,
    );

    Map<String, dynamic> toJson() => {
        "format": formatValues.reverse[format],
        "legality": legalityEnumValues.reverse[legality],
    };
}

enum Format {
    COMMANDER,
    LEGACY,
    MODERN,
    VINTAGE,
    TIME_SPIRAL_BLOCK,
    RAVNICA_BLOCK,
    ICE_AGE_BLOCK,
    TEMPEST_BLOCK,
    ONSLAUGHT_BLOCK,
    MASQUES_BLOCK,
    MIRAGE_BLOCK,
    URZA_BLOCK,
    SCARS_OF_MIRRODIN_BLOCK,
    MIRRODIN_BLOCK,
    AMONKHET_BLOCK,
    BATTLE_FOR_ZENDIKAR_BLOCK,
    INNISTRAD_BLOCK,
    INVASION_BLOCK,
    KALADESH_BLOCK,
    KAMIGAWA_BLOCK,
    KHANS_OF_TARKIR_BLOCK,
    LORWYN_SHADOWMOOR_BLOCK,
    ODYSSEY_BLOCK,
    RETURN_TO_RAVNICA_BLOCK,
    SHADOWS_OVER_INNISTRAD_BLOCK,
    SHARDS_OF_ALARA_BLOCK,
    STANDARD,
    THEROS_BLOCK,
    UN_SETS,
    ZENDIKAR_BLOCK
}

final formatValues = EnumValues({
    "Commander": Format.COMMANDER,
    "Legacy": Format.LEGACY,
    "Modern": Format.MODERN,
    "Vintage": Format.VINTAGE,
    "Time Spiral Block": Format.TIME_SPIRAL_BLOCK,
    "Ravnica Block": Format.RAVNICA_BLOCK,
    "Ice Age Block": Format.ICE_AGE_BLOCK,
    "Tempest Block": Format.TEMPEST_BLOCK,
    "Onslaught Block": Format.ONSLAUGHT_BLOCK,
    "Masques Block": Format.MASQUES_BLOCK,
    "Mirage Block": Format.MIRAGE_BLOCK,
    "Urza Block": Format.URZA_BLOCK,
    "Scars of Mirrodin Block": Format.SCARS_OF_MIRRODIN_BLOCK,
    "Mirrodin Block": Format.MIRRODIN_BLOCK,
    "Amonkhet Block": Format.AMONKHET_BLOCK,
    "Battle for Zendikar Block": Format.BATTLE_FOR_ZENDIKAR_BLOCK,
    "Innistrad Block": Format.INNISTRAD_BLOCK,
    "Invasion Block": Format.INVASION_BLOCK,
    "Kaladesh Block": Format.KALADESH_BLOCK,
    "Kamigawa Block": Format.KAMIGAWA_BLOCK,
    "Khans of Tarkir Block": Format.KHANS_OF_TARKIR_BLOCK,
    "Lorwyn-Shadowmoor Block": Format.LORWYN_SHADOWMOOR_BLOCK,
    "Odyssey Block": Format.ODYSSEY_BLOCK,
    "Return to Ravnica Block": Format.RETURN_TO_RAVNICA_BLOCK,
    "Shadows over Innistrad Block": Format.SHADOWS_OVER_INNISTRAD_BLOCK,
    "Shards of Alara Block": Format.SHARDS_OF_ALARA_BLOCK,
    "Standard": Format.STANDARD,
    "Theros Block": Format.THEROS_BLOCK,
    "Un-Sets": Format.UN_SETS,
    "Zendikar Block": Format.ZENDIKAR_BLOCK
});

enum LegalityEnum {
    LEGAL,
    BANNED,
    RESTRICTED
}

final legalityEnumValues = EnumValues({
    "Legal": LegalityEnum.LEGAL,
    "Banned": LegalityEnum.BANNED,
    "Restricted": LegalityEnum.RESTRICTED
});

enum Rarity {
    UNCOMMON,
    RARE,
    COMMON,
    BASIC_LAND
}

final rarityValues = EnumValues({
    "Uncommon": Rarity.UNCOMMON,
    "Rare": Rarity.RARE,
    "Common": Rarity.COMMON,
    "Basic Land": Rarity.BASIC_LAND
});

class Ruling {
    final DateTime date;
    final String text;

    Ruling({
        required this.date,
        required this.text,
    });

    factory Ruling.fromJson(Map<String, dynamic> json) => Ruling(
        date: DateTime.parse(json["date"]),
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "text": text,
    };
}

enum Supertype {
    BASIC
}

final supertypeValues = EnumValues({
    "Basic": Supertype.BASIC
});

enum Type {
    CREATURE,
    INSTANT,
    ENCHANTMENT,
    ARTIFACT,
    SORCERY,
    LAND
}

final typeValues = EnumValues({
    "Creature": Type.CREATURE,
    "Instant": Type.INSTANT,
    "Enchantment": Type.ENCHANTMENT,
    "Artifact": Type.ARTIFACT,
    "Sorcery": Type.SORCERY,
    "Land": Type.LAND
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

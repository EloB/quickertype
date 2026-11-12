// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final String? version;
    final List<Fruit>? fruits;
    final List<Vehicle>? vehicles;

    TopLevel({
        this.version,
        this.fruits,
        this.vehicles,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        version: json["version"] == null ? null : ((x) => RegExp("^\\d{1,5}.{1}\\d{1,5}.{1}\\d{1,5}\u0024").hasMatch(x) ? x : throw FormatException("Expected matching string"))(json["version"]),
        fruits: json["fruits"] == null ? null : List<Fruit>.from(json["fruits"]!.map((x) => Fruit.fromJson(x))),
        vehicles: json["vehicles"] == null ? null : List<Vehicle>.from(json["vehicles"]!.map((x) => Vehicle.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "version": version,
        "fruits": fruits == null ? null : List<dynamic>.from(fruits!.map((x) => x.toJson())),
        "vehicles": vehicles == null ? null : List<dynamic>.from(vehicles!.map((x) => x.toJson())),
    };
}

class Fruit {
    final bool? apple;
    final List<Berry>? berries;
    final bool? orange;

    Fruit({
        this.apple,
        this.berries,
        this.orange,
    });

    factory Fruit.fromJson(Map<String, dynamic> json) => Fruit(
        apple: json["apple"],
        berries: json["berries"] == null ? null : List<Berry>.from(json["berries"]!.map((x) => Berry.fromJson(x))),
        orange: json["orange"],
    );

    Map<String, dynamic> toJson() => {
        "apple": apple,
        "berries": berries == null ? null : List<dynamic>.from(berries!.map((x) => x.toJson())),
        "orange": orange,
    };
}

class Berry {
    final Color? color;
    final String? name;
    final List<Shape>? shapes;

    Berry({
        this.color,
        this.name,
        this.shapes,
    });

    factory Berry.fromJson(Map<String, dynamic> json) => Berry(
        color: json["color"] == null ? null : Color.fromJson(json["color"]),
        name: json["name"] == null ? null : ((x) => x.runes.length >= 1 && true ? x : throw FormatException("Expected bounded string"))(json["name"]),
        shapes: json["shapes"] == null ? null : List<Shape>.from(json["shapes"]!.map((x) => Shape.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "color": color?.toJson(),
        "name": name,
        "shapes": shapes == null ? null : List<dynamic>.from(shapes!.map((x) => x.toJson())),
    };
}

class Color {
    final double? rgb;

    Color({
        this.rgb,
    });

    factory Color.fromJson(Map<String, dynamic> json) => Color(
        rgb: json["rgb"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "rgb": rgb,
    };
}

class Shape {
    final Geometry? geometry;
    final History? history;

    Shape({
        this.geometry,
        this.history,
    });

    factory Shape.fromJson(Map<String, dynamic> json) => Shape(
        geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
        history: json["history"] == null ? null : History.fromJson(json["history"]),
    );

    Map<String, dynamic> toJson() => {
        "geometry": geometry?.toJson(),
        "history": history?.toJson(),
    };
}

class Geometry {
    final RectShape? rectShape;
    final List<CircularShape>? circularShape;

    Geometry({
        this.rectShape,
        this.circularShape,
    });

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        rectShape: json["rectShape"] == null ? null : RectShape.fromJson(json["rectShape"]),
        circularShape: json["circularShape"] == null ? null : List<CircularShape>.from(json["circularShape"]!.map((x) => CircularShape.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "rectShape": rectShape?.toJson(),
        "circularShape": circularShape == null ? null : List<dynamic>.from(circularShape!.map((x) => x.toJson())),
    };
}

class CircularShape {
    final String? shapeName;

    CircularShape({
        this.shapeName,
    });

    factory CircularShape.fromJson(Map<String, dynamic> json) => CircularShape(
        shapeName: json["shapeName"],
    );

    Map<String, dynamic> toJson() => {
        "shapeName": shapeName,
    };
}

class RectShape {
    final List<Part>? parts;

    RectShape({
        this.parts,
    });

    factory RectShape.fromJson(Map<String, dynamic> json) => RectShape(
        parts: json["parts"] == null ? null : List<Part>.from(json["parts"]!.map((x) => Part.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "parts": parts == null ? null : List<dynamic>.from(parts!.map((x) => x.toJson())),
    };
}

class Part {
    final String? depth;
    final String? length;
    final String? width;

    Part({
        this.depth,
        this.length,
        this.width,
    });

    factory Part.fromJson(Map<String, dynamic> json) => Part(
        depth: json["depth"],
        length: json["length"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "depth": depth,
        "length": length,
        "width": width,
    };
}

class History {
    final String? historyClass;

    History({
        this.historyClass,
    });

    factory History.fromJson(Map<String, dynamic> json) => History(
        historyClass: json["class"],
    );

    Map<String, dynamic> toJson() => {
        "class": historyClass,
    };
}

class Vehicle {
    final String? brand;
    final String? id;
    final Speed? speed;
    final bool? subModule;
    final VehicleType? type;
    final String? year;

    Vehicle({
        this.brand,
        this.id,
        this.speed,
        this.subModule,
        this.type,
        this.year,
    });

    factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        brand: json["brand"],
        id: json["id"] == null ? null : ((x) => x.runes.length >= 1 && true ? x : throw FormatException("Expected bounded string"))(json["id"]),
        speed: json["speed"] == null ? null : Speed.fromJson(json["speed"]),
        subModule: json["subModule"],
        type: json["type"] == null ? null : VehicleType.fromJson(json["type"]),
        year: json["year"],
    );

    Map<String, dynamic> toJson() => {
        "brand": brand,
        "id": id,
        "speed": speed?.toJson(),
        "subModule": subModule,
        "type": type?.toJson(),
        "year": year,
    };
}

class Speed {
    final Limit? velocity;

    Speed({
        this.velocity,
    });

    factory Speed.fromJson(Map<String, dynamic> json) => Speed(
        velocity: json["velocity"] == null ? null : Limit.fromJson(json["velocity"]),
    );

    Map<String, dynamic> toJson() => {
        "velocity": velocity?.toJson(),
    };
}

class Limit {
    final double? maximum;
    final double? minimum;

    Limit({
        this.maximum,
        this.minimum,
    });

    factory Limit.fromJson(Map<String, dynamic> json) => Limit(
        maximum: json["maximum"]?.toDouble(),
        minimum: json["minimum"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "maximum": maximum,
        "minimum": minimum,
    };
}

class VehicleType {
    final Name? name;
    final Axis? width;
    final Axis? length;

    VehicleType({
        this.name,
        this.width,
        this.length,
    });

    factory VehicleType.fromJson(Map<String, dynamic> json) => VehicleType(
        name: json["name"] == null ? null : nameValues.map[json["name"]]!,
        width: json["width"] == null ? null : axisValues.map[json["width"]]!,
        length: json["length"] == null ? null : axisValues.map[json["length"]]!,
    );

    Map<String, dynamic> toJson() => {
        "name": nameValues.reverse[name],
        "width": axisValues.reverse[width],
        "length": axisValues.reverse[length],
    };
}

enum Axis {
    X,
    Y,
    Z,
    XY,
    YZ,
    ZX
}

final axisValues = EnumValues({
    "X": Axis.X,
    "Y": Axis.Y,
    "Z": Axis.Z,
    "XY": Axis.XY,
    "YZ": Axis.YZ,
    "ZX": Axis.ZX
});

enum Name {
    TRUCK,
    BUS,
    CAR,
    VAN,
    TRAIN,
    BIKE,
    AEROPLANE,
    JEEP,
    TROLLEY
}

final nameValues = EnumValues({
    "truck": Name.TRUCK,
    "bus": Name.BUS,
    "car": Name.CAR,
    "van": Name.VAN,
    "train": Name.TRAIN,
    "Bike": Name.BIKE,
    "Aeroplane": Name.AEROPLANE,
    "Jeep": Name.JEEP,
    "Trolley": Name.TROLLEY
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

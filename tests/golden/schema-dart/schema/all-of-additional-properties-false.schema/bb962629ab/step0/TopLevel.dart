// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final double amount;
    final Frequency frequency;
    final String? description;
    final Type type;

    TopLevel({
        required this.amount,
        required this.frequency,
        this.description,
        required this.type,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        amount: json["amount"]?.toDouble(),
        frequency: frequencyValues.map[json["frequency"]]!,
        description: json["description"],
        type: typeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "frequency": frequencyValues.reverse[frequency],
        "description": description,
        "type": typeValues.reverse[type],
    };
}

enum Frequency {
    WEEKLY,
    MONTHLY,
    ANNUALLY
}

final frequencyValues = EnumValues({
    "Weekly": Frequency.WEEKLY,
    "Monthly": Frequency.MONTHLY,
    "Annually": Frequency.ANNUALLY
});

enum Type {
    GROSS_SALARY_AMOUNT,
    OVERTIME
}

final typeValues = EnumValues({
    "GrossSalaryAmount": Type.GROSS_SALARY_AMOUNT,
    "Overtime": Type.OVERTIME
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

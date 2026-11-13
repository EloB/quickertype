// To parse this JSON data, do
//
//     final generated = generatedFromJson(jsonString);

import 'dart:convert';

Generated generatedFromJson(String str) => Generated.fromJson(json.decode(str));

String generatedToJson(Generated data) => json.encode(data.toJson());

class Generated {
    final String greeting;
    final List<String> instructions;

    Generated({
        required this.greeting,
        required this.instructions,
    });

    factory Generated.fromJson(Map<String, dynamic> json) => Generated(
        greeting: json["greeting"],
        instructions: List<String>.from(json["instructions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "greeting": greeting,
        "instructions": List<dynamic>.from(instructions.map((x) => x)),
    };
}

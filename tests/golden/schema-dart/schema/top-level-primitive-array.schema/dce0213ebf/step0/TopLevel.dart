// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<String> topLevelFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String topLevelToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));

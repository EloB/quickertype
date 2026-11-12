// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

Map<String, dynamic> topLevelFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, dynamic>(k, v));

String topLevelToJson(Map<String, dynamic> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)));

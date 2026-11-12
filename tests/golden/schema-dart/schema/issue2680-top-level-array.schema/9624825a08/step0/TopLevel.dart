// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

List<int> topLevelFromJson(String str) => List<int>.from(json.decode(str).map((x) => x));

String topLevelToJson(List<int> data) => json.encode(List<dynamic>.from(data.map((x) => x)));

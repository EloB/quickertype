// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

double topLevelFromJson(String str) => json.decode(str)?.toDouble();

String topLevelToJson(double data) => json.encode(data);

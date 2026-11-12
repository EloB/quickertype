// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

dynamic topLevelFromJson(String str) => json.decode(str);

String topLevelToJson(dynamic data) => json.encode(data);

// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

int topLevelFromJson(String str) => json.decode(str);

String topLevelToJson(int data) => json.encode(data);

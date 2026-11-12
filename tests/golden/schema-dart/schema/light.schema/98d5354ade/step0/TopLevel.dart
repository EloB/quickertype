// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final LightParams lightParams;

    TopLevel({
        required this.lightParams,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        lightParams: LightParams.fromJson(json["LightParams"]),
    );

    Map<String, dynamic> toJson() => {
        "LightParams": lightParams.toJson(),
    };
}

class LightParams {
    final String appId;
    final String outletId;
    final String rgba;

    LightParams({
        required this.appId,
        required this.outletId,
        required this.rgba,
    });

    factory LightParams.fromJson(Map<String, dynamic> json) => LightParams(
        appId: json["app_id"],
        outletId: json["outlet_id"],
        rgba: json["rgba"],
    );

    Map<String, dynamic> toJson() => {
        "app_id": appId,
        "outlet_id": outletId,
        "rgba": rgba,
    };
}

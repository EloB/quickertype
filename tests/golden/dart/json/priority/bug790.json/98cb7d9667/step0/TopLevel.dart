// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<TopLevel> childrenData;
    final int id;
    final bool isActive;
    final int level;
    final String name;
    final int parentId;
    final int position;
    final int productCount;

    TopLevel({
        required this.childrenData,
        required this.id,
        required this.isActive,
        required this.level,
        required this.name,
        required this.parentId,
        required this.position,
        required this.productCount,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        childrenData: List<TopLevel>.from(json["children_data"].map((x) => TopLevel.fromJson(x))),
        id: json["id"],
        isActive: json["is_active"],
        level: json["level"],
        name: json["name"],
        parentId: json["parent_id"],
        position: json["position"],
        productCount: json["product_count"],
    );

    Map<String, dynamic> toJson() => {
        "children_data": List<dynamic>.from(childrenData.map((x) => x.toJson())),
        "id": id,
        "is_active": isActive,
        "level": level,
        "name": name,
        "parent_id": parentId,
        "position": position,
        "product_count": productCount,
    };
}

// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Data? data;
    final List<Error>? errors;

    TopLevel({
        required this.data,
        this.errors,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        data: (json.containsKey("data") ? json["data"] : throw FormatException('Missing required property')) == null ? null : Data.fromJson((json.containsKey("data") ? json["data"] : throw FormatException('Missing required property'))),
        errors: json["errors"] == null ? null : List<Error>.from(json["errors"]!.map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "errors": errors == null ? null : List<dynamic>.from(errors!.map((x) => x.toJson())),
    };
}

class Data {
    final AddReactionPayload? addReaction;

    Data({
        required this.addReaction,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        addReaction: (json.containsKey("addReaction") ? json["addReaction"] : throw FormatException('Missing required property')) == null ? null : AddReactionPayload.fromJson((json.containsKey("addReaction") ? json["addReaction"] : throw FormatException('Missing required property'))),
    );

    Map<String, dynamic> toJson() => {
        "addReaction": addReaction?.toJson(),
    };
}

class AddReactionPayload {
    final String? clientMutationId;
    final Reaction reaction;
    final Reactable subject;

    AddReactionPayload({
        required this.clientMutationId,
        required this.reaction,
        required this.subject,
    });

    factory AddReactionPayload.fromJson(Map<String, dynamic> json) => AddReactionPayload(
        clientMutationId: (json.containsKey("clientMutationId") ? json["clientMutationId"] : throw FormatException('Missing required property')),
        reaction: Reaction.fromJson(json["reaction"]),
        subject: Reactable.fromJson(json["subject"]),
    );

    Map<String, dynamic> toJson() => {
        "clientMutationId": clientMutationId,
        "reaction": reaction.toJson(),
        "subject": subject.toJson(),
    };
}

class Reaction {
    final ReactionContent content;

    Reaction({
        required this.content,
    });

    factory Reaction.fromJson(Map<String, dynamic> json) => Reaction(
        content: reactionContentValues.map[json["content"]]!,
    );

    Map<String, dynamic> toJson() => {
        "content": reactionContentValues.reverse[content],
    };
}

enum ReactionContent {
    THUMBS_UP,
    THUMBS_DOWN,
    LAUGH,
    HOORAY,
    CONFUSED,
    HEART
}

final reactionContentValues = EnumValues({
    "THUMBS_UP": ReactionContent.THUMBS_UP,
    "THUMBS_DOWN": ReactionContent.THUMBS_DOWN,
    "LAUGH": ReactionContent.LAUGH,
    "HOORAY": ReactionContent.HOORAY,
    "CONFUSED": ReactionContent.CONFUSED,
    "HEART": ReactionContent.HEART
});

class Reactable {
    final bool viewerCanReact;
    final List<Reaction>? reactionGroups;

    Reactable({
        required this.viewerCanReact,
        required this.reactionGroups,
    });

    factory Reactable.fromJson(Map<String, dynamic> json) => Reactable(
        viewerCanReact: json["viewerCanReact"],
        reactionGroups: (json.containsKey("reactionGroups") ? json["reactionGroups"] : throw FormatException('Missing required property')) == null ? null : List<Reaction>.from((json.containsKey("reactionGroups") ? json["reactionGroups"] : throw FormatException('Missing required property'))!.map((x) => Reaction.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "viewerCanReact": viewerCanReact,
        "reactionGroups": reactionGroups == null ? null : List<dynamic>.from(reactionGroups!.map((x) => x.toJson())),
    };
}

class Error {
    final String message;

    Error({
        required this.message,
    });

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}

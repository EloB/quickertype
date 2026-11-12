// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final Map<String, MissionSpec> missionSpecs;

    TopLevel({
        required this.missionSpecs,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        missionSpecs: Map.from(json["mission_specs"]).map((k, v) => MapEntry<String, MissionSpec>(k, MissionSpec.fromJson(v))),
    );

    Map<String, dynamic> toJson() => {
        "mission_specs": Map.from(missionSpecs).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
}

class MissionSpec {
    final Map<String, Objective> objectives;

    MissionSpec({
        required this.objectives,
    });

    factory MissionSpec.fromJson(Map<String, dynamic> json) => MissionSpec(
        objectives: Map.from(json["objectives"]).map((k, v) => MapEntry<String, Objective>(k, Objective.fromJson(v))),
    );

    Map<String, dynamic> toJson() => {
        "objectives": Map.from(objectives).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
}

class Objective {
    final Map<String, Reward> rewards;

    Objective({
        required this.rewards,
    });

    factory Objective.fromJson(Map<String, dynamic> json) => Objective(
        rewards: Map.from(json["rewards"]).map((k, v) => MapEntry<String, Reward>(k, Reward.fromJson(v))),
    );

    Map<String, dynamic> toJson() => {
        "rewards": Map.from(rewards).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
}

class Reward {
    Reward();

    factory Reward.fromJson(Map<String, dynamic> json) => Reward(
    );

    Map<String, dynamic> toJson() => {
    };
}

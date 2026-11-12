// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<StateElement> states;

    TopLevel({
        required this.states,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        states: List<StateElement>.from(json["states"].map((x) => StateElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "states": List<dynamic>.from(states.map((x) => x.toJson())),
    };
}

class StateElement {
    final StateState state;

    StateElement({
        required this.state,
    });

    factory StateElement.fromJson(Map<String, dynamic> json) => StateElement(
        state: StateState.fromJson(json["state"]),
    );

    Map<String, dynamic> toJson() => {
        "state": state.toJson(),
    };
}

class StateState {
    final String stateId;
    final String stateName;

    StateState({
        required this.stateId,
        required this.stateName,
    });

    factory StateState.fromJson(Map<String, dynamic> json) => StateState(
        stateId: json["state_id"],
        stateName: json["state_name"],
    );

    Map<String, dynamic> toJson() => {
        "state_id": stateId,
        "state_name": stateName,
    };
}

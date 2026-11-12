// To parse this JSON data, do
//
//     final topLevel = topLevelFromJson(jsonString);

import 'dart:convert';

TopLevel topLevelFromJson(String str) => TopLevel.fromJson(json.decode(str));

String topLevelToJson(TopLevel data) => json.encode(data.toJson());

class TopLevel {
    final List<Tx> txs;

    TopLevel({
        required this.txs,
    });

    factory TopLevel.fromJson(Map<String, dynamic> json) => TopLevel(
        txs: List<Tx>.from(json["txs"].map((x) => Tx.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "txs": List<dynamic>.from(txs.map((x) => x.toJson())),
    };
}

class Tx {
    final bool doubleSpend;
    final String hash;
    final List<Input> inputs;
    final int lockTime;
    final List<Out> out;
    final String relayedBy;
    final int size;
    final int time;
    final int txIndex;
    final int ver;
    final int vinSz;
    final int voutSz;

    Tx({
        required this.doubleSpend,
        required this.hash,
        required this.inputs,
        required this.lockTime,
        required this.out,
        required this.relayedBy,
        required this.size,
        required this.time,
        required this.txIndex,
        required this.ver,
        required this.vinSz,
        required this.voutSz,
    });

    factory Tx.fromJson(Map<String, dynamic> json) => Tx(
        doubleSpend: json["double_spend"],
        hash: json["hash"],
        inputs: List<Input>.from(json["inputs"].map((x) => Input.fromJson(x))),
        lockTime: json["lock_time"],
        out: List<Out>.from(json["out"].map((x) => Out.fromJson(x))),
        relayedBy: json["relayed_by"],
        size: json["size"],
        time: json["time"],
        txIndex: json["tx_index"],
        ver: json["ver"],
        vinSz: json["vin_sz"],
        voutSz: json["vout_sz"],
    );

    Map<String, dynamic> toJson() => {
        "double_spend": doubleSpend,
        "hash": hash,
        "inputs": List<dynamic>.from(inputs.map((x) => x.toJson())),
        "lock_time": lockTime,
        "out": List<dynamic>.from(out.map((x) => x.toJson())),
        "relayed_by": relayedBy,
        "size": size,
        "time": time,
        "tx_index": txIndex,
        "ver": ver,
        "vin_sz": vinSz,
        "vout_sz": voutSz,
    };
}

class Input {
    final Out prevOut;
    final String script;
    final int sequence;

    Input({
        required this.prevOut,
        required this.script,
        required this.sequence,
    });

    factory Input.fromJson(Map<String, dynamic> json) => Input(
        prevOut: Out.fromJson(json["prev_out"]),
        script: json["script"],
        sequence: json["sequence"],
    );

    Map<String, dynamic> toJson() => {
        "prev_out": prevOut.toJson(),
        "script": script,
        "sequence": sequence,
    };
}

class Out {
    final String addr;
    final int n;
    final String script;
    final bool spent;
    final int txIndex;
    final int type;
    final int value;

    Out({
        required this.addr,
        required this.n,
        required this.script,
        required this.spent,
        required this.txIndex,
        required this.type,
        required this.value,
    });

    factory Out.fromJson(Map<String, dynamic> json) => Out(
        addr: json["addr"],
        n: json["n"],
        script: json["script"],
        spent: json["spent"],
        txIndex: json["tx_index"],
        type: json["type"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "addr": addr,
        "n": n,
        "script": script,
        "spent": spent,
        "tx_index": txIndex,
        "type": type,
        "value": value,
    };
}

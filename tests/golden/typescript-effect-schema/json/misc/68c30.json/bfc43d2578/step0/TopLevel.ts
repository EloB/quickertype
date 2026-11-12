import * as S from "effect/Schema";


export class Out extends S.Class<Out>("Out")({
    "addr": S.String,
    "n": S.Int,
    "script": S.String,
    "spent": S.Boolean,
    "tx_index": S.Int,
    "type": S.Int,
    "value": S.Int,
}) {}

export class Input extends S.Class<Input>("Input")({
    "prev_out": Out,
    "script": S.String,
    "sequence": S.Int,
}) {}

export class Tx extends S.Class<Tx>("Tx")({
    "double_spend": S.Boolean,
    "hash": S.String,
    "inputs": S.Array(Input),
    "lock_time": S.Int,
    "out": S.Array(Out),
    "relayed_by": S.String,
    "size": S.Int,
    "time": S.Int,
    "tx_index": S.Int,
    "ver": S.Int,
    "vin_sz": S.Int,
    "vout_sz": S.Int,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "txs": S.Array(Tx),
}) {}

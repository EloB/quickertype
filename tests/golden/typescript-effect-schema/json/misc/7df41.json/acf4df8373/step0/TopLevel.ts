import * as S from "effect/Schema";


export class Pc extends S.Class<Pc>("Pc")({
    "count": S.Int,
    "label": S.String,
    "peak24": S.Int,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "pc": Pc,
    "ps3": Pc,
    "ps4": Pc,
    "xbox": Pc,
    "xone": Pc,
}) {}

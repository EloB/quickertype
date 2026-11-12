import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "continue": S.String,
    "": S.String,
    "null": S.String,
    "x'": S.String,
    "{}": S.String,
    "x\"": S.String,
    "undefined": S.String,
    "x": S.String,
    "x y": S.String,
}) {}

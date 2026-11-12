import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "anEasyOne": S.Int,
    "isMNISTLetter": S.Boolean,
    "JSONString": S.String,
    "PrettyEasyToo": S.Boolean,
    "should_know_that_id_is_an_initialism": S.String,
    "   spaces are separators  too  ": S.Boolean,
    "ZSR_HH_DEMO3_DELMATNR": S.Boolean,
}) {}

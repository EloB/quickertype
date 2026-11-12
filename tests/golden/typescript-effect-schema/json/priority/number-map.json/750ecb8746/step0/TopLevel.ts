import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "foo": S.Record({ key: S.String, value: S.Number}),
}) {}

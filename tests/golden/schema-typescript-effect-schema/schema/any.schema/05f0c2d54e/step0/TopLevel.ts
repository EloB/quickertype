import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "foo": S.Any,
    "values": S.Record({ key: S.String, value: S.Any}),
}) {}

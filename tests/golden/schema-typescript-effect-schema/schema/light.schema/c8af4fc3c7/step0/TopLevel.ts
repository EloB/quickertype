import * as S from "effect/Schema";


export class LightParams extends S.Class<LightParams>("LightParams")({
    "app_id": S.String,
    "outlet_id": S.String,
    "rgba": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "LightParams": LightParams,
}) {}

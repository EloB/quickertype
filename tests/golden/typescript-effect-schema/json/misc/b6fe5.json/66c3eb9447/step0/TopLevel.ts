import * as S from "effect/Schema";


export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "group": S.String,
    "movie": S.String,
    "movie-image": S.String,
    "theater": S.String,
}) {}

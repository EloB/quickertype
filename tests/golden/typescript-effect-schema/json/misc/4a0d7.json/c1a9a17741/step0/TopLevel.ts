import * as S from "effect/Schema";


export class TotalPopulation extends S.Class<TotalPopulation>("TotalPopulation")({
    "date": S.String.pipe(S.pattern(/^\d{4}-\d{2}-\d{2}$/)),
    "population": S.Int,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "total_population": S.Array(TotalPopulation),
}) {}

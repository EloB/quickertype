import * as S from "effect/Schema";


export class Person extends S.Class<Person>("Person")({
    "craft": S.String,
    "name": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "message": S.String,
    "number": S.Int,
    "people": S.Array(Person),
}) {}

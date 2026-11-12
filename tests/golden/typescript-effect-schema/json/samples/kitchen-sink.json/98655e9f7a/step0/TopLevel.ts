import * as S from "effect/Schema";


export class PurplePerson extends S.Class<PurplePerson>("PurplePerson")({
    "intOrString": S.Int,
    "name": S.String,
}) {}

export class PersonElement extends S.Class<PersonElement>("PersonElement")({
    "intOrString": S.Union(S.Int, S.NumberFromString.pipe(S.int())),
    "name": S.String,
    "optionalValue": S.optional(S.Boolean),
}) {}

export class DifferentThingClass extends S.Class<DifferentThingClass>("DifferentThingClass")({
    "name": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "booleanValue": S.Boolean,
    "dateValue": S.String,
    "differentThings": S.Array(S.Union(S.Int, S.NumberFromString.pipe(S.int()), DifferentThingClass)),
    "doubleValue": S.Number,
    "intValue": S.Int,
    "mapValue": S.Record({ key: S.String, value: S.NullOr(S.Int)}),
    "name with spaces": S.Null,
    "nullValue": S.Null,
    "nullableMapValue": S.Record({ key: S.String, value: S.NullOr(S.Int)}),
    "people": S.Array(PersonElement),
    "person": PurplePerson,
    "stringValue": S.String,
    "tuples": S.Array(S.Array(S.Union(S.Int, S.String))),
    "uuidValue": S.String,
}) {}

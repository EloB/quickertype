import * as S from "effect/Schema";


export class EmptyClass extends S.Class<EmptyClass>("EmptyClass")({
    "y": S.Int,
}) {}

export class ThisIsAToughOne extends S.Class<ThisIsAToughOne>("ThisIsAToughOne")({
    "\n\n\n": S.Int,
    "\"": S.Int,
}) {}

export class FooBla extends S.Class<FooBla>("FooBla")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class Foo extends S.Class<Foo>("Foo")({
    "bla": FooBla,
    "_": S.Int,
    "__": S.Int,
}) {}

export class Empty extends S.Class<Empty>("Empty")({
    "x": S.Int,
}) {}

export class TopLevelBla extends S.Class<TopLevelBla>("TopLevelBla")({
    "bar": S.Int,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "bla": TopLevelBla,
    "": Empty,
    "foo": Foo,
    "ThisIsA\ud83d\ude1cTough\"\n\nOne": ThisIsAToughOne,
    "!": S.Int,
    "Empty": EmptyClass,
}) {}

import * as S from "effect/Schema";


export const Axis = S.Literal(
    "X",
    "Y",
    "Z",
    "XY",
    "YZ",
    "ZX",
);
export type Axis = S.Schema.Type<typeof Axis>;


export const Name = S.Literal(
    "truck",
    "bus",
    "car",
    "van",
    "train",
    "Bike",
    "Aeroplane",
    "Jeep",
    "Trolley",
);
export type Name = S.Schema.Type<typeof Name>;

export class VehicleType extends S.Class<VehicleType>("VehicleType")({
    "name": S.optional(Name),
    "width": S.optional(Axis),
    "length": S.optional(Axis),
}) {}

export class Limit extends S.Class<Limit>("Limit")({
    "maximum": S.optional(S.Number),
    "minimum": S.optional(S.Number),
}) {}

export class Speed extends S.Class<Speed>("Speed")({
    "velocity": S.optional(Limit),
}) {}

export class Vehicle extends S.Class<Vehicle>("Vehicle")({
    "brand": S.optional(S.String),
    "id": S.optional(S.String.pipe(S.filter(value => Array.from(value).length >= 1))),
    "speed": S.optional(Speed),
    "subModule": S.optional(S.Boolean),
    "type": S.optional(VehicleType),
    "year": S.optional(S.String),
}) {}

export class History extends S.Class<History>("History")({
    "class": S.optional(S.String),
}) {}

export class Part extends S.Class<Part>("Part")({
    "depth": S.optional(S.String),
    "length": S.optional(S.String),
    "width": S.optional(S.String),
}) {}

export class RectShape extends S.Class<RectShape>("RectShape")({
    "parts": S.optional(S.Array(Part)),
}) {}

export class CircularShape extends S.Class<CircularShape>("CircularShape")({
    "shapeName": S.optional(S.String),
}) {}

export class Geometry extends S.Class<Geometry>("Geometry")({
    "rectShape": S.optional(RectShape),
    "circularShape": S.optional(S.Array(CircularShape)),
}) {}

export class Shape extends S.Class<Shape>("Shape")({
    "geometry": S.optional(Geometry),
    "history": S.optional(History),
}) {}

export class Color extends S.Class<Color>("Color")({
    "rgb": S.optional(S.Number),
}) {}

export class Berry extends S.Class<Berry>("Berry")({
    "color": S.optional(Color),
    "name": S.optional(S.String.pipe(S.filter(value => Array.from(value).length >= 1))),
    "shapes": S.optional(S.Array(Shape)),
}) {}

export class Fruit extends S.Class<Fruit>("Fruit")({
    "apple": S.optional(S.Boolean),
    "berries": S.optional(S.Array(Berry)),
    "orange": S.optional(S.Boolean),
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "version": S.optional(S.String.pipe(S.pattern(new RegExp("^\\d{1,5}.{1}\\d{1,5}.{1}\\d{1,5}$")))),
    "fruits": S.optional(S.Array(Fruit)),
    "vehicles": S.optional(S.Array(Vehicle)),
}) {}

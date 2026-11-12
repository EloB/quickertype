import * as z from "zod";


export const AxisSchema = z.enum([
    "X",
    "Y",
    "Z",
    "XY",
    "YZ",
    "ZX",
]);
export type Axis = z.infer<typeof AxisSchema>;


export const NameSchema = z.enum([
    "truck",
    "bus",
    "car",
    "van",
    "train",
    "Bike",
    "Aeroplane",
    "Jeep",
    "Trolley",
]);
export type Name = z.infer<typeof NameSchema>;

export const ColorSchema = z.object({
    "rgb": z.number().optional(),
});
export type Color = z.infer<typeof ColorSchema>;

export const CircularShapeSchema = z.object({
    "shapeName": z.string().optional(),
});
export type CircularShape = z.infer<typeof CircularShapeSchema>;

export const PartSchema = z.object({
    "depth": z.string().optional(),
    "length": z.string().optional(),
    "width": z.string().optional(),
});
export type Part = z.infer<typeof PartSchema>;

export const HistorySchema = z.object({
    "class": z.string().optional(),
});
export type History = z.infer<typeof HistorySchema>;

export const LimitSchema = z.object({
    "maximum": z.number().optional(),
    "minimum": z.number().optional(),
});
export type Limit = z.infer<typeof LimitSchema>;

export const VehicleTypeSchema = z.object({
    "name": NameSchema.optional(),
    "width": AxisSchema.optional(),
    "length": AxisSchema.optional(),
});
export type VehicleType = z.infer<typeof VehicleTypeSchema>;

export const RectShapeSchema = z.object({
    "parts": z.array(PartSchema).optional(),
});
export type RectShape = z.infer<typeof RectShapeSchema>;

export const SpeedSchema = z.object({
    "velocity": LimitSchema.optional(),
});
export type Speed = z.infer<typeof SpeedSchema>;

export const GeometrySchema = z.object({
    "rectShape": RectShapeSchema.optional(),
    "circularShape": z.array(CircularShapeSchema).optional(),
});
export type Geometry = z.infer<typeof GeometrySchema>;

export const VehicleSchema = z.object({
    "brand": z.string().optional(),
    "id": z.string().refine(value => Array.from(value).length >= 1).optional(),
    "speed": SpeedSchema.optional(),
    "subModule": z.boolean().optional(),
    "type": VehicleTypeSchema.optional(),
    "year": z.string().optional(),
});
export type Vehicle = z.infer<typeof VehicleSchema>;

export const ShapeSchema = z.object({
    "geometry": GeometrySchema.optional(),
    "history": HistorySchema.optional(),
});
export type Shape = z.infer<typeof ShapeSchema>;

export const BerrySchema = z.object({
    "color": ColorSchema.optional(),
    "name": z.string().refine(value => Array.from(value).length >= 1).optional(),
    "shapes": z.array(ShapeSchema).optional(),
});
export type Berry = z.infer<typeof BerrySchema>;

export const FruitSchema = z.object({
    "apple": z.boolean().optional(),
    "berries": z.array(BerrySchema).optional(),
    "orange": z.boolean().optional(),
});
export type Fruit = z.infer<typeof FruitSchema>;

export const TopLevelSchema = z.object({
    "version": z.string().regex(new RegExp("^\\d{1,5}.{1}\\d{1,5}.{1}\\d{1,5}$")).optional(),
    "fruits": z.array(FruitSchema).optional(),
    "vehicles": z.array(VehicleSchema).optional(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;

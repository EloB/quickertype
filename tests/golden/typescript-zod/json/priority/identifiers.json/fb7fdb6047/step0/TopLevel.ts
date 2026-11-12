import * as z from "zod";


export const TopLevelBlaSchema = z.object({
    "bar": z.number().int(),
});
export type TopLevelBla = z.infer<typeof TopLevelBlaSchema>;

export const EmptySchema = z.object({
    "x": z.number().int(),
});
export type Empty = z.infer<typeof EmptySchema>;

export const FooBlaSchema = z.object({
});
export type FooBla = z.infer<typeof FooBlaSchema>;

export const ThisIsAToughOneSchema = z.object({
    "\n\n\n": z.number().int(),
    "\"": z.number().int(),
});
export type ThisIsAToughOne = z.infer<typeof ThisIsAToughOneSchema>;

export const EmptyClassSchema = z.object({
    "y": z.number().int(),
});
export type EmptyClass = z.infer<typeof EmptyClassSchema>;

export const FooSchema = z.object({
    "bla": FooBlaSchema,
    "_": z.number().int(),
    "__": z.number().int(),
});
export type Foo = z.infer<typeof FooSchema>;

export const TopLevelSchema = z.object({
    "bla": TopLevelBlaSchema,
    "": EmptySchema,
    "foo": FooSchema,
    "ThisIsA\ud83d\ude1cTough\"\n\nOne": ThisIsAToughOneSchema,
    "!": z.number().int(),
    "Empty": EmptyClassSchema,
});
export type TopLevel = z.infer<typeof TopLevelSchema>;

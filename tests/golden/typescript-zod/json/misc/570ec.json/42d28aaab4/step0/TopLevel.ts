import * as z from "zod";


export const SchemeSchema = z.enum([
    "DEP5",
    "SPDX",
    "Trove",
]);
export type Scheme = z.infer<typeof SchemeSchema>;

export const IdentifierSchema = z.object({
    "identifier": z.string(),
    "scheme": SchemeSchema,
});
export type Identifier = z.infer<typeof IdentifierSchema>;

export const LinkSchema = z.object({
    "note": z.string(),
    "url": z.string(),
});
export type Link = z.infer<typeof LinkSchema>;

export const OtherNameSchema = z.object({
    "name": z.string(),
    "note": z.union([z.null(), z.string()]),
});
export type OtherName = z.infer<typeof OtherNameSchema>;

export const TextSchema = z.object({
    "media_type": z.string(),
    "title": z.string(),
    "url": z.string(),
});
export type Text = z.infer<typeof TextSchema>;

export const TopLevelElementSchema = z.object({
    "id": z.string(),
    "identifiers": z.array(IdentifierSchema),
    "keywords": z.array(z.string()),
    "links": z.array(LinkSchema),
    "name": z.string(),
    "other_names": z.array(OtherNameSchema),
    "superseded_by": z.null(),
    "text": z.array(TextSchema),
});
export type TopLevelElement = z.infer<typeof TopLevelElementSchema>;

export const TopLevelSchema = z.array(TopLevelElementSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;

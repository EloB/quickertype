import * as z from "zod";


export const SchemeSchema = z.enum([
    "SPDX",
    "Trove",
    "DEP5",
]);
export type Scheme = z.infer<typeof SchemeSchema>;


export const KeywordSchema = z.enum([
    "discouraged",
    "non-reusable",
    "osi-approved",
]);
export type Keyword = z.infer<typeof KeywordSchema>;


export const NoteSchema = z.enum([
    "OSI Page",
]);
export type Note = z.infer<typeof NoteSchema>;


export const MediaTypeSchema = z.enum([
    "text/html",
]);
export type MediaType = z.infer<typeof MediaTypeSchema>;


export const TitleSchema = z.enum([
    "HTML",
]);
export type Title = z.infer<typeof TitleSchema>;

export const IdentifierSchema = z.object({
    "identifier": z.string(),
    "scheme": SchemeSchema,
});
export type Identifier = z.infer<typeof IdentifierSchema>;

export const LinkSchema = z.object({
    "note": NoteSchema,
    "url": z.string(),
});
export type Link = z.infer<typeof LinkSchema>;

export const TextSchema = z.object({
    "media_type": MediaTypeSchema,
    "title": TitleSchema,
    "url": z.string(),
});
export type Text = z.infer<typeof TextSchema>;

export const TopLevelElementSchema = z.object({
    "id": z.string(),
    "identifiers": z.array(IdentifierSchema),
    "keywords": z.array(KeywordSchema),
    "links": z.array(LinkSchema),
    "name": z.string(),
    "other_names": z.array(z.any()),
    "superseded_by": z.null(),
    "text": z.array(TextSchema),
});
export type TopLevelElement = z.infer<typeof TopLevelElementSchema>;

export const TopLevelSchema = z.array(TopLevelElementSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;

import * as z from "zod";


export const LanguageSchema = z.enum([
    "Markdown",
]);
export type Language = z.infer<typeof LanguageSchema>;


export const TypeSchema = z.enum([
    "text/plain",
]);
export type Type = z.infer<typeof TypeSchema>;

export const FileSchema = z.object({
    "filename": z.string(),
    "language": z.union([z.null(), LanguageSchema]),
    "raw_url": z.string(),
    "size": z.number().int(),
    "type": TypeSchema,
});
export type File = z.infer<typeof FileSchema>;

export const TopLevelElementSchema = z.object({
    "comments": z.number().int(),
    "comments_url": z.string(),
    "commits_url": z.string(),
    "created_at": z.string().pipe(z.coerce.date()),
    "description": z.union([z.null(), z.string()]),
    "files": z.record(z.string(), FileSchema),
    "forks_url": z.string(),
    "git_pull_url": z.string(),
    "git_push_url": z.string(),
    "html_url": z.string(),
    "id": z.string(),
    "public": z.boolean(),
    "truncated": z.boolean(),
    "updated_at": z.string().pipe(z.coerce.date()),
    "url": z.string(),
    "user": z.null(),
});
export type TopLevelElement = z.infer<typeof TopLevelElementSchema>;

export const TopLevelSchema = z.array(TopLevelElementSchema);
export type TopLevel = z.infer<typeof TopLevelSchema>;

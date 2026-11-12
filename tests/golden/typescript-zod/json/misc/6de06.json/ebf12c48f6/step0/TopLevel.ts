import * as z from "zod";


export const PostHintSchema = z.enum([
    "link",
    "image",
    "rich:video",
]);
export type PostHint = z.infer<typeof PostHintSchema>;


export const SubredditTypeSchema = z.enum([
    "public",
]);
export type SubredditType = z.infer<typeof SubredditTypeSchema>;


export const KindSchema = z.enum([
    "t3",
]);
export type Kind = z.infer<typeof KindSchema>;

export const OembedSchema = z.object({
    "description": z.string(),
    "height": z.number().int(),
    "html": z.string(),
    "provider_name": z.string(),
    "provider_url": z.string(),
    "thumbnail_height": z.number().int(),
    "thumbnail_url": z.string(),
    "thumbnail_width": z.number().int(),
    "title": z.string(),
    "type": z.string(),
    "version": z.string(),
    "width": z.number().int(),
});
export type Oembed = z.infer<typeof OembedSchema>;

export const MediaEmbedSchema = z.object({
    "content": z.string().optional(),
    "height": z.number().int().optional(),
    "scrolling": z.boolean().optional(),
    "width": z.number().int().optional(),
});
export type MediaEmbed = z.infer<typeof MediaEmbedSchema>;

export const SourceSchema = z.object({
    "height": z.number().int(),
    "url": z.string(),
    "width": z.number().int(),
});
export type Source = z.infer<typeof SourceSchema>;

export const GifSchema = z.object({
    "resolutions": z.array(SourceSchema),
    "source": SourceSchema,
});
export type Gif = z.infer<typeof GifSchema>;

export const MediaSchema = z.object({
    "oembed": OembedSchema,
    "type": z.string(),
});
export type Media = z.infer<typeof MediaSchema>;

export const VariantsSchema = z.object({
    "gif": GifSchema.optional(),
    "mp4": GifSchema.optional(),
    "nsfw": GifSchema.optional(),
    "obfuscated": GifSchema.optional(),
});
export type Variants = z.infer<typeof VariantsSchema>;

export const ImageSchema = z.object({
    "id": z.string(),
    "resolutions": z.array(SourceSchema),
    "source": SourceSchema,
    "variants": VariantsSchema,
});
export type Image = z.infer<typeof ImageSchema>;

export const PreviewSchema = z.object({
    "enabled": z.boolean(),
    "images": z.array(ImageSchema),
});
export type Preview = z.infer<typeof PreviewSchema>;

export const ChildDataSchema = z.object({
    "approved_at_utc": z.null(),
    "approved_by": z.null(),
    "archived": z.boolean(),
    "author": z.string(),
    "author_flair_css_class": z.union([z.null(), z.string()]),
    "author_flair_text": z.union([z.null(), z.string()]),
    "banned_at_utc": z.null(),
    "banned_by": z.null(),
    "brand_safe": z.boolean(),
    "can_gild": z.boolean(),
    "can_mod_post": z.boolean(),
    "clicked": z.boolean(),
    "contest_mode": z.boolean(),
    "created": z.number(),
    "created_utc": z.number(),
    "distinguished": z.null(),
    "domain": z.string(),
    "downs": z.number().int(),
    "edited": z.boolean(),
    "gilded": z.number().int(),
    "hidden": z.boolean(),
    "hide_score": z.boolean(),
    "id": z.string(),
    "is_self": z.boolean(),
    "is_video": z.boolean(),
    "likes": z.null(),
    "link_flair_css_class": z.union([z.null(), z.string()]),
    "link_flair_text": z.union([z.null(), z.string()]),
    "locked": z.boolean(),
    "media": z.union([z.null(), MediaSchema]),
    "media_embed": MediaEmbedSchema,
    "mod_reports": z.array(z.any()),
    "name": z.string(),
    "num_comments": z.number().int(),
    "num_reports": z.null(),
    "over_18": z.boolean(),
    "permalink": z.string(),
    "post_hint": PostHintSchema.optional(),
    "preview": PreviewSchema.optional(),
    "quarantine": z.boolean(),
    "removal_reason": z.null(),
    "report_reasons": z.null(),
    "saved": z.boolean(),
    "score": z.number().int(),
    "secure_media": z.union([z.null(), MediaSchema]),
    "secure_media_embed": MediaEmbedSchema,
    "selftext": z.string(),
    "selftext_html": z.union([z.null(), z.string()]),
    "spoiler": z.boolean(),
    "stickied": z.boolean(),
    "subreddit": z.string(),
    "subreddit_id": z.string(),
    "subreddit_name_prefixed": z.string(),
    "subreddit_type": SubredditTypeSchema,
    "suggested_sort": z.union([z.null(), z.string()]),
    "thumbnail": z.string(),
    "thumbnail_height": z.union([z.null(), z.number().int()]),
    "thumbnail_width": z.union([z.null(), z.number().int()]),
    "title": z.string(),
    "ups": z.number().int(),
    "url": z.string(),
    "user_reports": z.array(z.any()),
    "view_count": z.null(),
    "visited": z.boolean(),
});
export type ChildData = z.infer<typeof ChildDataSchema>;

export const ChildSchema = z.object({
    "data": ChildDataSchema,
    "kind": KindSchema,
});
export type Child = z.infer<typeof ChildSchema>;

export const TopLevelDataSchema = z.object({
    "after": z.string(),
    "before": z.null(),
    "children": z.array(ChildSchema),
    "modhash": z.string(),
});
export type TopLevelData = z.infer<typeof TopLevelDataSchema>;

export const TopLevelSchema = z.object({
    "data": TopLevelDataSchema,
    "kind": z.string(),
});
export type TopLevel = z.infer<typeof TopLevelSchema>;

import * as z from "zod";


export const DistinguishedSchema = z.enum([
    "admin",
]);
export type Distinguished = z.infer<typeof DistinguishedSchema>;


export const DomainSchema = z.enum([
    "self.announcements",
    "i.redd.it",
]);
export type Domain = z.infer<typeof DomainSchema>;


export const PostHintSchema = z.enum([
    "self",
    "image",
]);
export type PostHint = z.infer<typeof PostHintSchema>;


export const SubredditSchema = z.enum([
    "announcements",
]);
export type Subreddit = z.infer<typeof SubredditSchema>;


export const SubredditIdSchema = z.enum([
    "t5_2r0ij",
]);
export type SubredditId = z.infer<typeof SubredditIdSchema>;


export const SubredditNamePrefixedSchema = z.enum([
    "r/announcements",
]);
export type SubredditNamePrefixed = z.infer<typeof SubredditNamePrefixedSchema>;


export const SubredditTypeSchema = z.enum([
    "restricted",
]);
export type SubredditType = z.infer<typeof SubredditTypeSchema>;


export const KindSchema = z.enum([
    "t3",
]);
export type Kind = z.infer<typeof KindSchema>;

export const MediaEmbedSchema = z.object({
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

export const VariantsSchema = z.object({
    "gif": GifSchema.optional(),
    "mp4": GifSchema.optional(),
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
    "author_flair_css_class": z.null(),
    "author_flair_text": z.null(),
    "banned_at_utc": z.null(),
    "banned_by": z.null(),
    "brand_safe": z.boolean(),
    "can_gild": z.boolean(),
    "can_mod_post": z.boolean(),
    "clicked": z.boolean(),
    "contest_mode": z.boolean(),
    "created": z.number(),
    "created_utc": z.number(),
    "distinguished": DistinguishedSchema,
    "domain": DomainSchema,
    "downs": z.number().int(),
    "edited": z.union([z.boolean(), z.number()]),
    "gilded": z.number().int(),
    "hidden": z.boolean(),
    "hide_score": z.boolean(),
    "id": z.string(),
    "is_self": z.boolean(),
    "is_video": z.boolean(),
    "likes": z.null(),
    "link_flair_css_class": z.null(),
    "link_flair_text": z.null(),
    "locked": z.boolean(),
    "media": z.null(),
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
    "secure_media": z.null(),
    "secure_media_embed": MediaEmbedSchema,
    "selftext": z.string(),
    "selftext_html": z.union([z.null(), z.string()]),
    "spoiler": z.boolean(),
    "stickied": z.boolean(),
    "subreddit": SubredditSchema,
    "subreddit_id": SubredditIdSchema,
    "subreddit_name_prefixed": SubredditNamePrefixedSchema,
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

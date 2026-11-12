import * as z from "zod";


export const SubredditSchema = z.enum([
    "worldnews",
]);
export type Subreddit = z.infer<typeof SubredditSchema>;


export const SubredditIdSchema = z.enum([
    "t5_2qh13",
]);
export type SubredditId = z.infer<typeof SubredditIdSchema>;


export const SubredditNamePrefixedSchema = z.enum([
    "r/worldnews",
]);
export type SubredditNamePrefixed = z.infer<typeof SubredditNamePrefixedSchema>;


export const SubredditTypeSchema = z.enum([
    "public",
]);
export type SubredditType = z.infer<typeof SubredditTypeSchema>;


export const KindSchema = z.enum([
    "t3",
]);
export type Kind = z.infer<typeof KindSchema>;

export const MediaEmbedSchema = z.object({
});
export type MediaEmbed = z.infer<typeof MediaEmbedSchema>;

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
    "media": z.null(),
    "media_embed": MediaEmbedSchema,
    "mod_reports": z.array(z.any()),
    "name": z.string(),
    "num_comments": z.number().int(),
    "num_reports": z.null(),
    "over_18": z.boolean(),
    "permalink": z.string(),
    "quarantine": z.boolean(),
    "removal_reason": z.null(),
    "report_reasons": z.null(),
    "saved": z.boolean(),
    "score": z.number().int(),
    "secure_media": z.null(),
    "secure_media_embed": MediaEmbedSchema,
    "selftext": z.string(),
    "selftext_html": z.null(),
    "spoiler": z.boolean(),
    "stickied": z.boolean(),
    "subreddit": SubredditSchema,
    "subreddit_id": SubredditIdSchema,
    "subreddit_name_prefixed": SubredditNamePrefixedSchema,
    "subreddit_type": SubredditTypeSchema,
    "suggested_sort": z.null(),
    "thumbnail": z.string(),
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

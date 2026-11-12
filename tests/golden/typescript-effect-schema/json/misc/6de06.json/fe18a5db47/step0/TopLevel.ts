import * as S from "effect/Schema";


export const PostHint = S.Literal(
    "link",
    "image",
    "rich:video",
);
export type PostHint = S.Schema.Type<typeof PostHint>;


export const SubredditType = S.Literal(
    "public",
);
export type SubredditType = S.Schema.Type<typeof SubredditType>;


export const Kind = S.Literal(
    "t3",
);
export type Kind = S.Schema.Type<typeof Kind>;

export class Source extends S.Class<Source>("Source")({
    "height": S.Int,
    "url": S.String,
    "width": S.Int,
}) {}

export class Image extends S.Class<Image>("Image")({
    "id": S.String,
    "resolutions": S.Array(Source),
    "source": Source,
    "variants": S.suspend(() => Variants),
}) {}

export class Preview extends S.Class<Preview>("Preview")({
    "enabled": S.Boolean,
    "images": S.Array(Image),
}) {}

export class MediaEmbed extends S.Class<MediaEmbed>("MediaEmbed")({
    "content": S.optional(S.String),
    "height": S.optional(S.Int),
    "scrolling": S.optional(S.Boolean),
    "width": S.optional(S.Int),
}) {}

export class Oembed extends S.Class<Oembed>("Oembed")({
    "description": S.String,
    "height": S.Int,
    "html": S.String,
    "provider_name": S.String,
    "provider_url": S.String,
    "thumbnail_height": S.Int,
    "thumbnail_url": S.String,
    "thumbnail_width": S.Int,
    "title": S.String,
    "type": S.String,
    "version": S.String,
    "width": S.Int,
}) {}

export class Media extends S.Class<Media>("Media")({
    "oembed": Oembed,
    "type": S.String,
}) {}

export class ChildData extends S.Class<ChildData>("ChildData")({
    "approved_at_utc": S.Null,
    "approved_by": S.Null,
    "archived": S.Boolean,
    "author": S.String,
    "author_flair_css_class": S.NullOr(S.String),
    "author_flair_text": S.NullOr(S.String),
    "banned_at_utc": S.Null,
    "banned_by": S.Null,
    "brand_safe": S.Boolean,
    "can_gild": S.Boolean,
    "can_mod_post": S.Boolean,
    "clicked": S.Boolean,
    "contest_mode": S.Boolean,
    "created": S.Number,
    "created_utc": S.Number,
    "distinguished": S.Null,
    "domain": S.String,
    "downs": S.Int,
    "edited": S.Boolean,
    "gilded": S.Int,
    "hidden": S.Boolean,
    "hide_score": S.Boolean,
    "id": S.String,
    "is_self": S.Boolean,
    "is_video": S.Boolean,
    "likes": S.Null,
    "link_flair_css_class": S.NullOr(S.String),
    "link_flair_text": S.NullOr(S.String),
    "locked": S.Boolean,
    "media": S.NullOr(Media),
    "media_embed": MediaEmbed,
    "mod_reports": S.Array(S.Any),
    "name": S.String,
    "num_comments": S.Int,
    "num_reports": S.Null,
    "over_18": S.Boolean,
    "permalink": S.String,
    "post_hint": S.optional(PostHint),
    "preview": S.optional(Preview),
    "quarantine": S.Boolean,
    "removal_reason": S.Null,
    "report_reasons": S.Null,
    "saved": S.Boolean,
    "score": S.Int,
    "secure_media": S.NullOr(Media),
    "secure_media_embed": MediaEmbed,
    "selftext": S.String,
    "selftext_html": S.NullOr(S.String),
    "spoiler": S.Boolean,
    "stickied": S.Boolean,
    "subreddit": S.String,
    "subreddit_id": S.String,
    "subreddit_name_prefixed": S.String,
    "subreddit_type": SubredditType,
    "suggested_sort": S.NullOr(S.String),
    "thumbnail": S.String,
    "thumbnail_height": S.NullOr(S.Int),
    "thumbnail_width": S.NullOr(S.Int),
    "title": S.String,
    "ups": S.Int,
    "url": S.String,
    "user_reports": S.Array(S.Any),
    "view_count": S.Null,
    "visited": S.Boolean,
}) {}

export class Child extends S.Class<Child>("Child")({
    "data": ChildData,
    "kind": Kind,
}) {}

export class TopLevelData extends S.Class<TopLevelData>("TopLevelData")({
    "after": S.String,
    "before": S.Null,
    "children": S.Array(Child),
    "modhash": S.String,
}) {}

export class TopLevel extends S.Class<TopLevel>("TopLevel")({
    "data": TopLevelData,
    "kind": S.String,
}) {}

export class Gif extends S.Class<Gif>("Gif")({
    "resolutions": S.Array(Source),
    "source": Source,
}) {}

export class Variants extends S.Class<Variants>("Variants")({
    "gif": S.optional(Gif),
    "mp4": S.optional(Gif),
    "nsfw": S.optional(Gif),
    "obfuscated": S.optional(Gif),
}) {}

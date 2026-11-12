import * as S from "effect/Schema";


export const Subreddit = S.Literal(
    "worldnews",
);
export type Subreddit = S.Schema.Type<typeof Subreddit>;


export const SubredditId = S.Literal(
    "t5_2qh13",
);
export type SubredditId = S.Schema.Type<typeof SubredditId>;


export const SubredditNamePrefixed = S.Literal(
    "r/worldnews",
);
export type SubredditNamePrefixed = S.Schema.Type<typeof SubredditNamePrefixed>;


export const SubredditType = S.Literal(
    "public",
);
export type SubredditType = S.Schema.Type<typeof SubredditType>;


export const Kind = S.Literal(
    "t3",
);
export type Kind = S.Schema.Type<typeof Kind>;

export class MediaEmbed extends S.Class<MediaEmbed>("MediaEmbed")(S.Struct({}).pipe(S.filter(value => typeof value === "object" && value !== null && !Array.isArray(value)))
) {}

export class ChildData extends S.Class<ChildData>("ChildData")({
    "approved_at_utc": S.Null,
    "approved_by": S.Null,
    "archived": S.Boolean,
    "author": S.String,
    "author_flair_css_class": S.Null,
    "author_flair_text": S.Null,
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
    "media": S.Null,
    "media_embed": MediaEmbed,
    "mod_reports": S.Array(S.Any),
    "name": S.String,
    "num_comments": S.Int,
    "num_reports": S.Null,
    "over_18": S.Boolean,
    "permalink": S.String,
    "quarantine": S.Boolean,
    "removal_reason": S.Null,
    "report_reasons": S.Null,
    "saved": S.Boolean,
    "score": S.Int,
    "secure_media": S.Null,
    "secure_media_embed": MediaEmbed,
    "selftext": S.String,
    "selftext_html": S.Null,
    "spoiler": S.Boolean,
    "stickied": S.Boolean,
    "subreddit": Subreddit,
    "subreddit_id": SubredditId,
    "subreddit_name_prefixed": SubredditNamePrefixed,
    "subreddit_type": SubredditType,
    "suggested_sort": S.Null,
    "thumbnail": S.String,
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

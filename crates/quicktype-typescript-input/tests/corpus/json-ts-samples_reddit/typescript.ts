export interface TopLevel {
    data: TopLevelData;
    kind: string;
}

export interface TopLevelData {
    after:    string;
    before:   null;
    children: Child[];
    modhash:  string;
}

export interface Child {
    data: ChildData;
    kind: Kind;
}

export interface ChildData {
    approved_at_utc:         null;
    approved_by:             null;
    archived:                boolean;
    author:                  string;
    author_flair_css_class:  null | string;
    author_flair_text:       null | string;
    banned_at_utc:           null;
    banned_by:               null;
    brand_safe:              boolean;
    can_gild:                boolean;
    can_mod_post:            boolean;
    clicked:                 boolean;
    contest_mode:            boolean;
    created:                 number;
    created_utc:             number;
    distinguished:           null | string;
    domain:                  Domain;
    downs:                   number;
    edited:                  boolean;
    gilded:                  number;
    hidden:                  boolean;
    hide_score:              boolean;
    id:                      string;
    is_self:                 boolean;
    is_video:                boolean;
    likes:                   null;
    link_flair_css_class:    null | string;
    link_flair_text:         null | string;
    locked:                  boolean;
    media:                   null;
    media_embed:             object;
    mod_reports:             unknown[];
    name:                    string;
    num_comments:            number;
    num_reports:             null;
    over_18:                 boolean;
    parent_whitelist_status: WhitelistStatus;
    permalink:               string;
    post_hint:               PostHint;
    preview:                 Preview;
    quarantine:              boolean;
    removal_reason:          null;
    report_reasons:          null;
    saved:                   boolean;
    score:                   number;
    secure_media:            null;
    secure_media_embed:      object;
    selftext:                string;
    selftext_html:           null;
    spoiler:                 boolean;
    stickied:                boolean;
    subreddit:               Subreddit;
    subreddit_id:            SubredditID;
    subreddit_name_prefixed: SubredditNamePrefixed;
    subreddit_type:          SubredditType;
    suggested_sort:          null;
    thumbnail:               string;
    thumbnail_height:        number;
    thumbnail_width:         number;
    title:                   string;
    ups:                     number;
    url:                     string;
    user_reports:            unknown[];
    view_count:              null;
    visited:                 boolean;
    whitelist_status:        WhitelistStatus;
}

export type Domain = "reddit.com" | "i.imgur.com" | "imgur.com" | "i.redd.it";

export type WhitelistStatus = "all_ads";

export type PostHint = "link" | "image";

export interface Preview {
    enabled: boolean;
    images:  Image[];
}

export interface Image {
    id:          string;
    resolutions: Source[];
    source:      Source;
    variants:    Variants;
}

export interface Source {
    height: number;
    url:    string;
    width:  number;
}

export interface Variants {
    gif?: GIF;
    mp4?: GIF;
}

export interface GIF {
    resolutions: Source[];
    source:      Source;
}

export type Subreddit = "funny";

export type SubredditID = "t5_2qh33";

export type SubredditNamePrefixed = "r/funny";

export type SubredditType = "public";

export type Kind = "t3";

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
    author_flair_css_class:  null;
    author_flair_text:       null;
    banned_at_utc:           null;
    banned_by:               null;
    brand_safe:              boolean;
    can_gild:                boolean;
    can_mod_post:            boolean;
    clicked:                 boolean;
    contest_mode:            boolean;
    created:                 number;
    created_utc:             number;
    distinguished:           null;
    domain:                  string;
    downs:                   number;
    edited:                  boolean;
    gilded:                  number;
    hidden:                  boolean;
    hide_score:              boolean;
    id:                      string;
    is_self:                 boolean;
    is_video:                boolean;
    likes:                   null;
    link_flair_css_class:    null;
    link_flair_text:         null;
    locked:                  boolean;
    media:                   Media | null;
    media_embed:             MediaEmbed;
    mod_reports:             unknown[];
    name:                    string;
    num_comments:            number;
    num_reports:             null;
    over_18:                 boolean;
    permalink:               string;
    post_hint?:              PostHint;
    preview?:                Preview;
    quarantine:              boolean;
    removal_reason:          null;
    report_reasons:          null;
    saved:                   boolean;
    score:                   number;
    secure_media:            Media | null;
    secure_media_embed:      MediaEmbed;
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
    thumbnail_height:        number | null;
    thumbnail_width:         number | null;
    title:                   string;
    ups:                     number;
    url:                     string;
    user_reports:            unknown[];
    view_count:              null;
    visited:                 boolean;
}

export interface Media {
    oembed: Oembed;
    type:   string;
}

export interface Oembed {
    author_name:      string;
    author_url:       string;
    height:           number;
    html:             string;
    provider_name:    string;
    provider_url:     string;
    thumbnail_height: number;
    thumbnail_url:    string;
    thumbnail_width:  number;
    title:            string;
    type:             string;
    version:          string;
    width:            number;
}

export interface MediaEmbed {
    content?:   string;
    height?:    number;
    scrolling?: boolean;
    width?:     number;
}

export type PostHint = "rich:video" | "link";

export interface Preview {
    enabled: boolean;
    images:  Image[];
}

export interface Image {
    id:          string;
    resolutions: Source[];
    source:      Source;
    variants:    object;
}

export interface Source {
    height: number;
    url:    string;
    width:  number;
}

export type Subreddit = "todayilearned";

export type SubredditID = "t5_2qqjc";

export type SubredditNamePrefixed = "r/todayilearned";

export type SubredditType = "public";

export type Kind = "t3";

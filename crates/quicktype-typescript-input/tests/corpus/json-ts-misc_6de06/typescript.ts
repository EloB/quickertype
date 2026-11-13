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
    link_flair_css_class:    null | string;
    link_flair_text:         null | string;
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
    selftext_html:           null | string;
    spoiler:                 boolean;
    stickied:                boolean;
    subreddit:               string;
    subreddit_id:            string;
    subreddit_name_prefixed: string;
    subreddit_type:          SubredditType;
    suggested_sort:          null | string;
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
    description:      string;
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

export type PostHint = "link" | "image" | "rich:video";

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
    gif?:        GIF;
    mp4?:        GIF;
    nsfw?:       GIF;
    obfuscated?: GIF;
}

export interface GIF {
    resolutions: Source[];
    source:      Source;
}

export type SubredditType = "public";

export type Kind = "t3";

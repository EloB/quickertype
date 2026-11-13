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
    permalink:               string;
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
    title:                   string;
    ups:                     number;
    url:                     string;
    user_reports:            unknown[];
    view_count:              null;
    visited:                 boolean;
}

export type Domain = "self.AskReddit";

export type Subreddit = "AskReddit";

export type SubredditID = "t5_2qh1i";

export type SubredditNamePrefixed = "r/AskReddit";

export type SubredditType = "public";

export type Kind = "t3";

export interface TopLevel {
    data:       Datum[];
    meta:       Meta;
    pagination: Pagination;
}

export interface Datum {
    bitly_gif_url:     string;
    bitly_url:         string;
    content_url:       string;
    embed_url:         string;
    id:                string;
    images:            Images;
    import_datetime:   string;
    is_indexable:      number;
    rating:            Rating;
    slug:              string;
    source:            string;
    source_post_url:   string;
    source_tld:        string;
    trending_datetime: string;
    type:              Type;
    url:               string;
    user?:             User;
    username:          string;
}

export interface Images {
    "480w_still"?:            The480_WStill;
    downsized:                The480_WStill;
    downsized_large:          The480_WStill;
    downsized_medium:         The480_WStill;
    downsized_small:          DownsizedSmall;
    downsized_still:          The480_WStill;
    fixed_height:             FixedHeight;
    fixed_height_downsampled: FixedHeight;
    fixed_height_small:       FixedHeight;
    fixed_height_small_still: The480_WStill;
    fixed_height_still:       The480_WStill;
    fixed_width:              FixedHeight;
    fixed_width_downsampled:  FixedHeight;
    fixed_width_small:        FixedHeight;
    fixed_width_small_still:  The480_WStill;
    fixed_width_still:        The480_WStill;
    hd?:                      DownsizedSmall;
    looping:                  Looping;
    original:                 FixedHeight;
    original_mp4:             DownsizedSmall;
    original_still:           The480_WStill;
    preview:                  DownsizedSmall;
    preview_gif:              The480_WStill;
    preview_webp:             The480_WStill;
}

export interface The480_WStill {
    height: string;
    size?:  string;
    url:    string;
    width:  string;
}

export interface DownsizedSmall {
    height:   string;
    mp4:      string;
    mp4_size: string;
    width:    string;
}

export interface FixedHeight {
    frames?:   string;
    hash?:     string;
    height:    string;
    mp4?:      string;
    mp4_size?: string;
    size:      string;
    url:       string;
    webp:      string;
    webp_size: string;
    width:     string;
}

export interface Looping {
    mp4:      string;
    mp4_size: string;
}

export type Rating = "pg" | "g" | "pg-13" | "y";

export type Type = "gif";

export interface User {
    avatar_url:   string;
    banner_url:   string;
    display_name: string;
    profile_url:  string;
    twitter?:     string;
    username:     string;
}

export interface Meta {
    msg:         string;
    response_id: string;
    status:      number;
}

export interface Pagination {
    count:       number;
    offset:      number;
    total_count: number;
}

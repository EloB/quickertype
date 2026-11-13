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
    downsized:                Downsized;
    downsized_large:          Downsized;
    downsized_medium:         Downsized;
    downsized_small:          DownsizedSmall;
    downsized_still:          Downsized;
    fixed_height:             FixedHeight;
    fixed_height_downsampled: FixedHeight;
    fixed_height_small:       FixedHeight;
    fixed_height_small_still: Downsized;
    fixed_height_still:       Downsized;
    fixed_width:              FixedHeight;
    fixed_width_downsampled:  FixedHeight;
    fixed_width_small:        FixedHeight;
    fixed_width_small_still:  Downsized;
    fixed_width_still:        Downsized;
    hd?:                      DownsizedSmall;
    looping:                  Looping;
    original:                 FixedHeight;
    original_mp4:             DownsizedSmall;
    original_still:           Downsized;
    preview:                  DownsizedSmall;
    preview_gif:              Downsized;
    preview_webp:             Downsized;
}

export interface Downsized {
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

export type Rating = "g" | "pg" | "y";

export type Type = "gif";

export interface User {
    avatar_url:   string;
    banner_url:   string;
    display_name: string;
    profile_url:  string;
    twitter:      string;
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

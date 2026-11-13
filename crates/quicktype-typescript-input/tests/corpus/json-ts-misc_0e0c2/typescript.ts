export interface TopLevel {
    count:    number;
    next:     string;
    previous: null;
    results:  Result[];
}

export interface Result {
    active_screens: number;
    collections:    Collection[];
    details:        Detail[];
    duration:       number;
    fav_movie:      FavMovie;
    id:             number;
    images:         Image[];
    language:       ResultLanguage;
    release_date:   Date;
    stars:          number;
    tags:           unknown[] | null;
    title:          string;
    videos:         Video[];
    vote_score:     VoteScore;
    watches:        number;
}

export interface Collection {
    id:     number;
    movies: number[];
    name:   string;
    slug:   string;
}

export interface Detail {
    cast:      string;
    director:  string;
    id:        number;
    language:  DetailLanguage;
    storyline: string;
    tagline:   string;
    title:     string;
}

export type DetailLanguage = "en" | "th";

export interface FavMovie {
    follow:  boolean;
    star:    boolean;
    watched: boolean;
}

export interface Image {
    favs:      number;
    id:        number;
    thumbnail: string;
    type:      Type;
    url:       string;
}

export type Type = "Poster" | "Backdrop";

export type ResultLanguage = "en" | "-";

export interface Video {
    kind:     string;
    language: ResultLanguage;
    source:   string;
    url:      string;
}

export interface VoteScore {
    avg:   number;
    score: number;
    total: number;
}

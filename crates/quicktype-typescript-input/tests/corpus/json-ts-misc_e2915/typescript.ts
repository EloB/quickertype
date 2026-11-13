export interface TopLevel {
    query: Query;
}

export interface Query {
    count:   number;
    created: Date;
    lang:    string;
    results: Results;
}

export interface Results {
    channel: Channel;
}

export interface Channel {
    astronomy:     Astronomy;
    atmosphere:    Atmosphere;
    description:   string;
    image:         Image;
    item:          Item;
    language:      string;
    lastBuildDate: string;
    link:          string;
    location:      Location;
    title:         string;
    ttl:           string;
    units:         Units;
    wind:          Wind;
}

export interface Astronomy {
    sunrise: string;
    sunset:  string;
}

export interface Atmosphere {
    humidity:   string;
    pressure:   string;
    rising:     string;
    visibility: string;
}

export interface Image {
    height: string;
    link:   string;
    title:  string;
    url:    string;
    width:  string;
}

export interface Item {
    condition:   Condition;
    description: string;
    forecast:    Forecast[];
    guid:        GUID;
    lat:         string;
    link:        string;
    long:        string;
    pubDate:     string;
    title:       string;
}

export interface Condition {
    code: string;
    date: string;
    temp: string;
    text: string;
}

export interface Forecast {
    code: string;
    date: string;
    day:  string;
    high: string;
    low:  string;
    text: Text;
}

export type Text = "Sunny";

export interface GUID {
    isPermaLink: string;
}

export interface Location {
    city:    string;
    country: string;
    region:  string;
}

export interface Units {
    distance:    string;
    pressure:    string;
    speed:       string;
    temperature: string;
}

export interface Wind {
    chill:     string;
    direction: string;
    speed:     string;
}

export interface TopLevel {
    IATA:    string;
    ICAO:    string;
    city:    string;
    delay:   string;
    name:    string;
    state:   string;
    status:  Status;
    weather: Weather;
}

export interface Status {
    avgDelay:     string;
    closureBegin: string;
    closureEnd:   string;
    endTime:      string;
    maxDelay:     string;
    minDelay:     string;
    reason:       string;
    trend:        string;
    type:         string;
}

export interface Weather {
    meta:       Meta;
    temp:       string;
    visibility: number;
    weather:    string;
    wind:       string;
}

export interface Meta {
    credit:  string;
    updated: string;
    url:     string;
}

export interface TopLevel {
    args:    object;
    data:    string;
    files:   object;
    form:    object;
    headers: Headers;
    origin:  string;
    url:     string;
}

export interface Headers {
    "Accept-Encoding": string;
    Connection:        string;
    Host:              string;
    "User-Agent":      string;
}

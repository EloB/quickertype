export interface TopLevel {
    metadata: Metadata;
    results:  Result[];
}

export interface Metadata {
    executionTime: number;
    responseInfo:  ResponseInfo;
    resultset:     Resultset;
}

export interface ResponseInfo {
    developerMessage: string;
    status:           number;
}

export interface Resultset {
    count:    number;
    page:     number;
    pagesize: number;
}

export interface Result {
    attachment: unknown[];
    body:       string;
    changed:    string;
    component:  Component[];
    created:    string;
    date:       string;
    image:      unknown[];
    number:     null;
    teaser:     null;
    title:      string;
    topic:      unknown[];
    url:        string;
    uuid:       string;
    vuuid:      string;
}

export interface Component {
    name: string;
    uuid: string;
}

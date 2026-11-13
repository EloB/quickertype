export interface TopLevel {
    iss_position: IssPosition;
    message:      string;
    timestamp:    number;
}

export interface IssPosition {
    latitude:  string;
    longitude: string;
}

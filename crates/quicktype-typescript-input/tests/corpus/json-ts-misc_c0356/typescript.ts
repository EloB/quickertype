export interface TopLevel {
    data:        { [key: string]: Datum };
    description: Description;
}

export interface Datum {
    anomaly: string;
    value:   string;
}

export interface Description {
    base_period: string;
    missing:     number;
    title:       string;
}

export interface TopLevel {
    data:        { [key: string]: string };
    description: Description;
}

export interface Description {
    base_period: string;
    missing:     string;
    title:       string;
    units:       string;
}

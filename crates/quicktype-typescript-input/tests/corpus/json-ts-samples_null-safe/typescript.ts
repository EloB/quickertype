export interface TopLevel {
    item: Item[];
}

export interface Item {
    address?:    Address;
    created_at?: Date;
    name:        string;
    sex:         number | null;
}

export interface Address {
    city:    string;
    country: string;
    street:  string;
}

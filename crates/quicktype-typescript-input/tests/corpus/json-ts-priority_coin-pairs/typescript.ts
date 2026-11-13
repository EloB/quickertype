export interface TopLevel {
    pairs:       { [key: string]: Pair };
    server_time: number;
}

export interface Pair {
    decimal_places: number;
    fee:            number;
    hidden:         number;
    max_amount:     number;
    max_price:      number;
    min_amount:     number;
    min_price:      number;
    min_total:      number;
}

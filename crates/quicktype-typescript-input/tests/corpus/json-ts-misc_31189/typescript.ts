export interface TopLevel {
    details: string;
    rates:   Rate[];
    version: null;
}

export interface Rate {
    code:         string;
    country_code: string;
    name:         string;
    periods:      Period[];
}

export interface Period {
    effective_from: Date | EffectiveFromEnum;
    rates:          Rates;
}

export type EffectiveFromEnum = "0000-01-01";

export interface Rates {
    parking?:       number;
    reduced?:       number;
    reduced1?:      number;
    reduced2?:      number;
    standard:       number;
    super_reduced?: number;
}

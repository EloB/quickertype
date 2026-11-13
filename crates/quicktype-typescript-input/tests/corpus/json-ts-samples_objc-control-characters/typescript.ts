export interface TopLevel {
    "#{1+1}": number;
    literal:  string;
    values:   Value[];
}

export type Value = "c0\u0001\u001b\u001f" | "c1\u007f\u0080\u0085\u009f";

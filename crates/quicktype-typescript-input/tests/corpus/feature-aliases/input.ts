export type ID = string;
export type Kind = "a" | "b" | "c";
export type Num = 1 | 2 | 3;
export interface T { id: ID; kind: Kind; n: Num; mixed: "x" | 1 | true; b: true | false; }

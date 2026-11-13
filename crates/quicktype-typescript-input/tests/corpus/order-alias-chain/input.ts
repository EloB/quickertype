export type U1 = U2 | A;
export type U2 = B[] | C;
export interface A { a: 1 }
export interface B { b: 1 }
export interface C { c: 1 }
export interface T { u: U1; v: C | B | A; }

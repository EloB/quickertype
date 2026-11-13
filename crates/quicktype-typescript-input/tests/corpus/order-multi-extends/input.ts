export interface P { p: A | B }
export interface Q { q: B | A }
export interface A { a: 1 }
export interface B { b: 1 }
export interface T extends P, Q { t: A[] | B[]; }

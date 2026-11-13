export type V = { a: A } | { b: B } | A[];
export interface A { a: 1 }
export interface B { b: 1 }
export interface T { v: V; w: V[]; }

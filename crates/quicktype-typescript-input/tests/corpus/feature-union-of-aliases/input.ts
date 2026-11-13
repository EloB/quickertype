export type A = { a: string };
export type B = { b: number };
export type U = A | B;
export interface T { u: U; arr: U[]; opt?: U; }

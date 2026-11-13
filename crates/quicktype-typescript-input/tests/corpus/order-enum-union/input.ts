export enum E { X = "x", Y = "y" }
export interface A { a: 1 }
export interface T { u: E | A | null; v: A[] | E[]; }

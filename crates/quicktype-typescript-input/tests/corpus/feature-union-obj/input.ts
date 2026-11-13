export interface A { a: string; }
export interface B { b: number; }
export interface T { u: A | B | null; v?: A | string[]; w: (A | B)[]; }

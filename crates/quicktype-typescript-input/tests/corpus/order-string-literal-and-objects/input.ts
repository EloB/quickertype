export interface A { a: 1 }
export interface B { b: 1 }
export interface T { u: "x" | B | "y" | A | null; }

/** doc */
export type U = B | A;
export interface A { a: 1 }
export interface B { b: 1 }
export interface T { /** prop */ u?: U; v: U[]; }

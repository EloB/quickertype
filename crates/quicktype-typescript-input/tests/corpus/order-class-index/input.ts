export class C { [k: string]: A | B; }
export interface B { b: 1 }
export interface A { a: 1 }
export interface T { c: C; u: A | B; }

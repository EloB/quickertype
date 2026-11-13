export class A { a = 1; }
export class B { b = "x"; }
export type AB = A & B;
export interface T { ab: AB; }

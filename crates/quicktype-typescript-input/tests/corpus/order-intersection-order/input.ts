export interface A { a: string }
export interface B { b: number }
export type AB = B & A;
export interface T { ab: AB; ba: A & B; }

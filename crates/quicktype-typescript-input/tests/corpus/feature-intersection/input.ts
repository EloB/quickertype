export interface A { a: string; }
export interface B { b?: number; }
export type AB = A & B;
export interface T { ab: AB; inline: A & { c: boolean }; }

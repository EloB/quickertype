type Mutable<T> = { -readonly [K in keyof T]: T[K] };
export interface A { readonly a: string }
export interface T { r: Readonly<A>; m: Mutable<A>; }

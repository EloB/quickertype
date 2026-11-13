export interface Box<T> { v: T }
export interface A { a: string }
export interface B { b: string }
export interface T { u: Box<A> | Box<B> | B; w: Box<B>[] | A; }

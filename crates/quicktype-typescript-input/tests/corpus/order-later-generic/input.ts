export interface T { u: Box<B> | A; v: A | Box<A>; }
export interface A { a: 1 }
export interface B { b: 1 }
export interface Box<X> { x: X }

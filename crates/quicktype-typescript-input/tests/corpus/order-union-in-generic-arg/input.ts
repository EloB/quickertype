export interface Box<X> { x: X }
export interface A { a: 1 }
export interface B { b: 1 }
export interface T { u: Box<B | A>; v: Box<A | B>[]; }

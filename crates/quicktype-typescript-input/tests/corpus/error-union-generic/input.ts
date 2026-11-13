export interface Box<T> { v: T; }
export interface T { a: Box<string | number>; b: Box<number | string>; }

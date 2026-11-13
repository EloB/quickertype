export interface Box<T> { value: T; label?: string; }
export interface Holder { a: Box<string>; b: Box<number>; c: Box<Box<boolean>>; }

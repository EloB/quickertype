export interface A { a: string; shared: number; }
export interface B extends A { b: boolean; shared: 1; }
export interface C extends B, D { c: string; }
export interface D { d: number; }

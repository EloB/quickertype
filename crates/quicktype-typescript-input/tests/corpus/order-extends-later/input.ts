export interface T extends Base { u: B | A; }
export interface Base { b: A[] | B; }
export interface A { a: 1 }
export interface B { b: 1 }

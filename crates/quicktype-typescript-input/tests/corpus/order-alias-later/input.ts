export interface T { u: U; w: W | Y; }
export type U = W[] | X;
export type W = { w: Y | X };
export interface X { x: 1 }
export interface Y { y: 1 }

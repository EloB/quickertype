export function f(a: Z[] | Y): void {}
export interface Y { y: 1 }
export interface Z { z: 1 }
export interface T { u: Y | Z[]; }

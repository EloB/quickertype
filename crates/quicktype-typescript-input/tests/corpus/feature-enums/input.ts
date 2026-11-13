export enum N { A, B, C = 10, D }
export enum S { X = "x", Y = "y" }
export enum M { P = 1, Q = "q" }
export const enum CE { U = "u", V = "v" }
export interface T { n: N; s: S; m: M; c: CE; lit: S.X; }

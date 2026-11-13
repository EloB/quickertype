export enum E { A = 1 << 2, B = A | 1, C = "c".length }
export const enum F { X = "x" }
export interface T { e: E; f: F; }

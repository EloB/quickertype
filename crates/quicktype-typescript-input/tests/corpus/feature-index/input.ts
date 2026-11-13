export interface D { [key: string]: number; }
export interface E { [key: string]: Inner; extra: string; }
export interface Inner { x: number; }
export interface Arr { [i: number]: string; }
export interface T { d: D; e: E; r: Record<string, Inner>; m: { [k: string]: boolean }; arr: Arr; ro: { readonly [k: string]: string }; }

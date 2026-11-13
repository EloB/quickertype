export type L = (P | Q)[];
export type M = Array<Q | P>;
export interface Q { q: 1 }
export interface P { p: 1 }
export interface T { l: L; m: M; r: P[] | Q; }

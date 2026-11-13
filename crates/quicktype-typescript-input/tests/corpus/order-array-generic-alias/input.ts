export type L = Array<M | N>;
export interface N { n: 1 }
export interface M { m: 1 }
export interface T { l: L; u: N | M; }

export type Pair<X> = [left: X, right: X];
export interface T { p: Pair<string>; q: Pair<number> | null; }

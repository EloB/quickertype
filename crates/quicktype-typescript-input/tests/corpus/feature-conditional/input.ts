export type IsStr<T> = T extends string ? "yes" : "no";
export interface T { a: IsStr<string>; b: IsStr<number>; }

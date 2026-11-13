export type Keys = "a" | "b";
export type Mapped = { [K in Keys]: number };
export type MappedOpt = { [K in Keys]?: string };
export interface T { m: Mapped; o: MappedOpt; }

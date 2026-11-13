export interface Base { a: string; b: number; c?: boolean; }
export type P = Partial<Base>;
export type R = Required<Base>;
export type K = Pick<Base, "a" | "c">;
export type O = Omit<Base, "b">;
export type RO = Readonly<Base>;
export interface T { p: P; r: R; k: K; o: O; ro: RO; rec: Record<"x" | "y", number>; }

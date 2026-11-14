// Members without declarations of their own: labelled tuple elements with
// JSDoc on the labels, and members of mapped and keyed types.
export type Pair = [/** The first. */ first: string, /** The second. */ second: number];
export interface Labels {
  pair: Pair;
  rest: [/** A head. */ head: string, ...tail: number[]];
}
export interface Base {
  /** The a of Base. */
  a: string;
  /** The b of Base. */
  b: number;
}
export type Mapped = { [K in "a" | "b"]: string };
export type Picked = Pick<Base, "a">;
export type Remapped = { [K in keyof Base as `get_${K}`]: Base[K] };
export type Copied = { [K in keyof Base]: Base[K] };
export interface Holder {
  mapped: Mapped;
  picked: Picked;
  remapped: Remapped;
  copied: Copied;
  record: Record<"x" | "y", Base>;
}

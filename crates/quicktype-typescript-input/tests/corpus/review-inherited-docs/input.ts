// Documentation through a base whose member has it, below members with a
// tags-only JSDoc, an empty one, and none.
export interface A {
  /** The x of A. */
  x: string;
  /** The y of A. */
  y: string;
  /** The z of A. */
  z: string;
  /** The w of A. */
  w: string;
}
export interface B extends A {
  /** @deprecated */
  x: string;
  y: string;
  /** */
  z: string;
  /** Own w. */
  w: string;
}
export interface C extends B {
  x: string;
  y: string;
  w: string;
}

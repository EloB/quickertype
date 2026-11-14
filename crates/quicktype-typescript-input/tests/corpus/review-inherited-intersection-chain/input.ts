// An intersection in a type alias adds no base of its own, but a member
// that comes from an interface inherits through that interface's bases.
export interface Base {
  /** The x of Base. */
  x: string;
  /** The y of Base. */
  y: string;
}
export interface A extends Base {
  x: string;
}
export type T = A & {
  y: string;
  z: string;
};
export type U = { x: string } & { /** Literal x. */ x: string };
export interface Holder {
  t: T;
  u: U;
}

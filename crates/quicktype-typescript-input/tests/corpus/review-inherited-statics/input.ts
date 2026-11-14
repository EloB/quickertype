// Static members inherit from the base class's static side.
export class A {
  /** The static s of A. */
  static s: number = 1;
  /** The instance s of A. */
  s: number = 1;
  /** The static t of A. */
  static t: string = "";
}
export class B extends A {
  static s: number = 2;
  s: number = 2;
  static t: string = "b";
}
export interface Holder {
  b: B;
  k: typeof B;
}

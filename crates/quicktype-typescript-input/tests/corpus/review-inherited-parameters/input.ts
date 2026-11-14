// Constructor parameter properties, and a static member.
export class A {
  /** The s of A. */
  static s: number = 1;
  /**
   * @param p The p of A.
   */
  constructor(public p: number, /** The q of A. */ public q: string) {}
}
export class B extends A {
  static s: number = 2;
  constructor(public p: number, public q: string) {
    super(p, q);
  }
}
export interface Holder {
  b: B;
}

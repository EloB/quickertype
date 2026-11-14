// A chain of four interfaces: a member inherits from the nearest base that
// declares it, and through that base's own inheritance.
export interface A {
  /** The a of A. */
  a: string;
  /** The b of A. */
  b: string;
  c: string;
}
export interface B extends A {
  /** The b of B. */
  b: string;
  c: string;
}
export interface C extends B {
  a: string;
  b: string;
  /** @deprecated */
  c: string;
}
export interface D extends C {
  a: string;
  b: string;
  c: string;
}

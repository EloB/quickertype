/** Other X.
 * @TJS-additionalProperties false */
export interface X {
  /** @minimum 1 */
  a: number;
  b?: string;
  c: { d: number };
}
export type Mode = "fast" | "slow";
export enum Kind {
  One = "one",
  Two = "two",
}
export interface Y {
  x: X;
  m: Mode;
}

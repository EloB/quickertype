// Members merged through an intersection in a type alias.
export interface A {
  /** The a of A.
   * @minimum 1 */
  a: number;
  /** The c of A. */
  c: string;
}
export type T = A & {
  /** @maximum 3 */
  a: number;
  b: string;
  c: string;
};
export interface U {
  t: T;
  both: A & { d?: boolean };
}

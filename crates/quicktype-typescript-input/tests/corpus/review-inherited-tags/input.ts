// A property redeclared without JSDoc, below one with tags: neither
// TypeScript 5.9's checker-less getJsDocTags nor TypeScript 7's inherits them.
export interface A {
  /** @format date-time */
  at: string;
  /** @minimum 1 */
  n: number;
  /** Docs of m.
   * @maximum 9 */
  m: number;
}
export interface B extends A {
  at: string;
  n: number;
}
export interface C extends B {
  at: string;
  m: number;
}

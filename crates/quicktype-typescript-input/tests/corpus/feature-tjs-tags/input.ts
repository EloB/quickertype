export interface T {
  /** @items.type integer
   * @items.minimum 1 */
  a: number[];
  /** @additionalProperties true */
  b: { x: string };
  /** @TJS-pattern ^x */
  c: string;
  /** @TJS -format email */
  d: string;
  /** @nullable */
  e: Other;
  /** @minItems 2 @maxItems 3 */
  f: string[];
}
export interface Other { o: 1 }

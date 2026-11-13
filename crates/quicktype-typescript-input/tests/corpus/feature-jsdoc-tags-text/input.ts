/**
 * Top doc.
 * @deprecated use X
 * @example const x = 1;
 * @see Other
 */
export interface T {
  /** @description Overridden desc */
  a: string;
  /** @default {"x": 1} */
  b: { x: number };
  /** @examples [1, 2] */
  c: number;
  /** @$comment hi */
  d: string;
}

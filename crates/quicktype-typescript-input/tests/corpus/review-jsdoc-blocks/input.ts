// Several JSDoc blocks on one declaration (only the last counts), and
// @inheritDoc, which joins the base's documentation before the member's.
export interface Base {
  /** Base x. */
  x: string;
  /** Base y. */
  y: string;
  /** Base z. */
  z: string;
  /** Base w. */
  w: string;
}
/** First block. */
/** Second block. */
export interface Derived extends Base {
  /** Own x.
   * @inheritDoc */
  x: string;
  /** @inheritDoc */
  y: string;
  /** Own z. */
  z: string;
  /** Earlier. */
  /** @deprecated */
  w: string;
}

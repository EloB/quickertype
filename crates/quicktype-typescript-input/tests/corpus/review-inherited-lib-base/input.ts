// A base member from the library: its documentation is the library's.
export interface MyStrategy extends QueuingStrategyInit {
  highWaterMark: number;
  /** Own docs. */
  extra: string;
}
export interface MyError extends Error {
  message: string;
  name: string;
}
export interface Holder {
  strategy: MyStrategy;
  err: MyError;
}

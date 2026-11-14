// Two bases with the member documented: the first base in the extends
// clause gives its documentation; a member only one base has comes from it.
export interface First {
  /** From First. */
  x: string;
  y: string;
}
export interface Second {
  /** From Second. */
  x: string;
  /** Only in Second. */
  y: string;
  /** Second's z. */
  z: string;
}
export interface Both extends First, Second {
  x: string;
  y: string;
  z: string;
}
export interface Reversed extends Second, First {
  x: string;
  y: string;
}

// A class extending a class that implements an interface.
export interface I {
  /** From I. */
  x: string;
  /** From I too. */
  y: string;
}
export class P implements I {
  x: string = "";
  /** From P. */
  y: string = "";
}
export class Q extends P {
  x: string = "";
  y: string = "";
}

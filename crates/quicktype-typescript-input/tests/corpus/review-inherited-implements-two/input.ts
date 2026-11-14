// A class implementing two interfaces, with and without a base class.
export interface I {
  /** From I. */
  x: string;
  y: string;
}
export interface J {
  /** From J. */
  x: string;
  /** From J only. */
  y: string;
}
export class K implements I, J {
  x: string = "";
  y: string = "";
}
export class Base {
  y: string = "";
}
export class L extends Base implements J, I {
  x: string = "";
  y: string = "";
}

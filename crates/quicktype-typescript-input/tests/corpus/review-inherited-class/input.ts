// The same through class extends and implements.
export interface I {
  /** The i of I.
   * @minimum 2 */
  i: number;
  /** @deprecated */
  j: string;
}
export class P {
  /** The p of P.
   * @maximum 5 */
  p: number = 1;
  /** @deprecated */
  q: string = "";
  /** The r of P. */
  r: boolean = true;
}
export class K extends P implements I {
  p: number = 2;
  i: number = 3;
  j: string = "j";
  /** @format email */
  q: string = "a";
  /** @deprecated */
  r: boolean = false;
}
export class L extends K {
  p: number = 4;
  i: number = 5;
}

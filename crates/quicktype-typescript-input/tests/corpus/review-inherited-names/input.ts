// Member names that TypeScript escapes or keys apart: two and three leading
// underscores, and a private name (a class has its own and its base's).
export interface A {
  /** doc of __x */
  __x: string;
  /** doc of ___x */
  ___x: string;
  /** doc of _y */
  _y: string;
}
export interface B extends A {
  __x: string;
  ___x: string;
  _y: string;
}
export class C {
  /** doc of #p */
  #p: string = "";
  /** doc of q */
  q: string = "";
}
export class D extends C {
  #p: string = "";
  q: string = "";
}

// Getters and setters inherit the documentation of the base's getter or
// setter, else of the base's member.
export class A {
  private v = "";
  /** Gets g. */
  get g(): string { return this.v; }
  /** Sets g. */
  set g(x: string) { this.v = x; }
  /** Only a getter. */
  get h(): string { return ""; }
  /** The p of A. */
  p: string = "";
}
export class B extends A {
  get g(): string { return ""; }
  set g(x: string) {}
  get h(): string { return "b"; }
  get p(): string { return ""; }
}

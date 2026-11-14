// An overridden method next to an overridden property.
export class A {
  /** Runs it. */
  run(): void {}
  /** The count. */
  count: number = 0;
}
export class B extends A {
  run(): void {}
  count: number = 1;
}
export interface IA {
  /** Does it. */
  go(): void;
  /** The level. */
  level: number;
}
export interface IB extends IA {
  go(): void;
  level: number;
}

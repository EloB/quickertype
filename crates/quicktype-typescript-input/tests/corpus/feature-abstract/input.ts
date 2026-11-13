export abstract class Shape { kind: string = ""; }
export class Circle extends Shape { r: number = 1; }
export class Square extends Shape { side: number = 1; }
export interface T { s: Shape; }

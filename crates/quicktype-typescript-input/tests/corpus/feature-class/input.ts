export class Animal { name: string = "x"; legs: number = 4; private secret: string = "s"; protected p?: string; readonly r: boolean = true; static s: number = 1; method(): void {} get g(): string { return ""; } }
export class Dog extends Animal { bark: boolean = true; }

export class Z { z = 1; }
export class A { a = 1; }
export class T { u: A | Z = new A(); v?: Z[] | A; }

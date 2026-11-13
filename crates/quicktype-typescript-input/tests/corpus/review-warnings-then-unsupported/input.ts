export class C { a = foo(); b: () => void = () => {}; }
declare function foo(): number;

export interface TopLevel {
    bar: Bar[];
    foo: Bar[];
}

export interface Bar {
    x: X;
}

export type X = "three" | "one" | "two";

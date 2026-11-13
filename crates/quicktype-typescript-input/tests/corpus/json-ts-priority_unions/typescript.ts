export interface TopLevel {
    x: Array<number | null | string>;
    y: Array<number | null>;
    z: Array<number[] | ZClass | number>;
}

export interface ZClass {
    a: boolean;
}

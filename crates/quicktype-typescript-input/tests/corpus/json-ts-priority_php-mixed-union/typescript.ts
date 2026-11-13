export interface TopLevel {
    mixed: Array<boolean | MixedClass | number | null | string>;
}

export interface MixedClass {
    nested: string;
}

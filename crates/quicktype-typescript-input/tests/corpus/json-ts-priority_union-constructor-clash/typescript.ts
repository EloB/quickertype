export interface TopLevel {
    BoolInUnion: BoolInUnion;
    union:       Array<boolean | number>;
}

export interface BoolInUnion {
    a: boolean;
}

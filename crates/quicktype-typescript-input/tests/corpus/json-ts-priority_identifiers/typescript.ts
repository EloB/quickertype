export interface TopLevel {
    "":                                  Empty;
    "!":                                 number;
    Empty:                               EmptyClass;
    "ThisIsA\ud83d\ude1cTough\"\n\nOne": ThisIsAToughOne;
    bla:                                 TopLevelBla;
    foo:                                 Foo;
}

export interface Empty {
    x: number;
}

export interface EmptyClass {
    y: number;
}

export interface ThisIsAToughOne {
    "\n\n\n": number;
    "\"":     number;
}

export interface TopLevelBla {
    bar: number;
}

export interface Foo {
    _:   number;
    __:  number;
    bla: object;
}

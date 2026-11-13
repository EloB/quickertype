export interface TopLevel {
    pc:   PC;
    ps3:  PC;
    ps4:  PC;
    xbox: PC;
    xone: PC;
}

export interface PC {
    count:  number;
    label:  string;
    peak24: number;
}

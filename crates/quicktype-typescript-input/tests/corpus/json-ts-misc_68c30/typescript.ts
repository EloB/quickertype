export interface TopLevel {
    txs: Tx[];
}

export interface Tx {
    double_spend: boolean;
    hash:         string;
    inputs:       Input[];
    lock_time:    number;
    out:          Out[];
    relayed_by:   string;
    size:         number;
    time:         number;
    tx_index:     number;
    ver:          number;
    vin_sz:       number;
    vout_sz:      number;
}

export interface Input {
    prev_out: Out;
    script:   string;
    sequence: number;
}

export interface Out {
    addr:     string;
    n:        number;
    script:   string;
    spent:    boolean;
    tx_index: number;
    type:     number;
    value:    number;
}

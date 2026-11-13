export interface TopLevel {
    states: StateElement[];
}

export interface StateElement {
    state: StateState;
}

export interface StateState {
    state_id:   string;
    state_name: string;
}

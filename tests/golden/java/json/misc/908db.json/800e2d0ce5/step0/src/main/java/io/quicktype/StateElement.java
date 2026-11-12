package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class StateElement {
    private StateState state;

    @JsonProperty("state")
    public StateState getState() { return state; }
    @JsonProperty("state")
    public void setState(StateState value) { this.state = value; }
}

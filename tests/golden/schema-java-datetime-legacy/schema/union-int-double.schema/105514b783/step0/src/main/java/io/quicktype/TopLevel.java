package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Value value;

    @JsonProperty("value")
    public Value getValue() { return value; }
    @JsonProperty("value")
    public void setValue(Value value) { this.value = value; }
}

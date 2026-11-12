package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Elif {
    private long elif;

    @JsonProperty("elif")
    public long getElif() { return elif; }
    @JsonProperty("elif")
    public void setElif(long value) { this.elif = value; }
}

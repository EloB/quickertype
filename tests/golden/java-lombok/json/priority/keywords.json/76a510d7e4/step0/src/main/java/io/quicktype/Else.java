package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Else {
    private long elseElse;

    @JsonProperty("else")
    public long getElseElse() { return elseElse; }
    @JsonProperty("else")
    public void setElseElse(long value) { this.elseElse = value; }
}

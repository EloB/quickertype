package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Infix {
    private long infix;

    @JsonProperty("infix")
    public long getInfix() { return infix; }
    @JsonProperty("infix")
    public void setInfix(long value) { this.infix = value; }
}

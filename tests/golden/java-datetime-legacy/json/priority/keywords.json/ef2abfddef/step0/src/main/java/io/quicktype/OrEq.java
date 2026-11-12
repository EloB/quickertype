package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class OrEq {
    private long orEq;

    @JsonProperty("or_eq")
    public long getOrEq() { return orEq; }
    @JsonProperty("or_eq")
    public void setOrEq(long value) { this.orEq = value; }
}

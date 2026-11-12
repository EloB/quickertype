package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class AndEq {
    private long andEq;

    @JsonProperty("and_eq")
    public long getAndEq() { return andEq; }
    @JsonProperty("and_eq")
    public void setAndEq(long value) { this.andEq = value; }
}

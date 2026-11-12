package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Yield {
    private long yield;

    @JsonProperty("yield")
    public long getYield() { return yield; }
    @JsonProperty("yield")
    public void setYield(long value) { this.yield = value; }
}

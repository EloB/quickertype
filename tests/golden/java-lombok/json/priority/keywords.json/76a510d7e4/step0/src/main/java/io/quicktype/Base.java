package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Base {
    private long base;

    @JsonProperty("base")
    public long getBase() { return base; }
    @JsonProperty("base")
    public void setBase(long value) { this.base = value; }
}

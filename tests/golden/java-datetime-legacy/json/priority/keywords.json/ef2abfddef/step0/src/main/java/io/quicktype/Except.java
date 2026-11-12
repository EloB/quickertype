package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Except {
    private long except;

    @JsonProperty("except")
    public long getExcept() { return except; }
    @JsonProperty("except")
    public void setExcept(long value) { this.except = value; }
}

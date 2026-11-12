package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Lazy {
    private long lazy;

    @JsonProperty("lazy")
    public long getLazy() { return lazy; }
    @JsonProperty("lazy")
    public void setLazy(long value) { this.lazy = value; }
}

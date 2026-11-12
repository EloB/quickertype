package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Fallthrough {
    private long fallthrough;

    @JsonProperty("fallthrough")
    public long getFallthrough() { return fallthrough; }
    @JsonProperty("fallthrough")
    public void setFallthrough(long value) { this.fallthrough = value; }
}

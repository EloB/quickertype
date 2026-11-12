package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Uint {
    private long uint;

    @JsonProperty("uint")
    public long getUint() { return uint; }
    @JsonProperty("uint")
    public void setUint(long value) { this.uint = value; }
}

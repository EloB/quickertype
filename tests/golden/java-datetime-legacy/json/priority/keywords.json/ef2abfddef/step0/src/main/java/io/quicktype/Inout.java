package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Inout {
    private long inout;

    @JsonProperty("inout")
    public long getInout() { return inout; }
    @JsonProperty("inout")
    public void setInout(long value) { this.inout = value; }
}

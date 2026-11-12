package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Obj4None {
    private long none;

    @JsonProperty("none")
    public long getNone() { return none; }
    @JsonProperty("none")
    public void setNone(long value) { this.none = value; }
}

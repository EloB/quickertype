package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class NoneClass {
    private long none;

    @JsonProperty("None")
    public long getNone() { return none; }
    @JsonProperty("None")
    public void setNone(long value) { this.none = value; }
}

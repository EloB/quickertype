package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class S {
    private long s;

    @JsonProperty("s")
    public long getS() { return s; }
    @JsonProperty("s")
    public void setS(long value) { this.s = value; }
}

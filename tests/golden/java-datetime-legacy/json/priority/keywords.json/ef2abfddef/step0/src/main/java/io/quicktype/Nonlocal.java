package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Nonlocal {
    private long nonlocal;

    @JsonProperty("nonlocal")
    public long getNonlocal() { return nonlocal; }
    @JsonProperty("nonlocal")
    public void setNonlocal(long value) { this.nonlocal = value; }
}

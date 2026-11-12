package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Alignof {
    private long alignof;

    @JsonProperty("alignof")
    public long getAlignof() { return alignof; }
    @JsonProperty("alignof")
    public void setAlignof(long value) { this.alignof = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class XorEq {
    private long xorEq;

    @JsonProperty("xor_eq")
    public long getXorEq() { return xorEq; }
    @JsonProperty("xor_eq")
    public void setXorEq(long value) { this.xorEq = value; }
}

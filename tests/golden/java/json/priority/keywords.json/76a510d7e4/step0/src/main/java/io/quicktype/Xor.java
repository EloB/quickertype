package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Xor {
    private long xor;

    @JsonProperty("xor")
    public long getXor() { return xor; }
    @JsonProperty("xor")
    public void setXor(long value) { this.xor = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Bitand {
    private long bitand;

    @JsonProperty("bitand")
    public long getBitand() { return bitand; }
    @JsonProperty("bitand")
    public void setBitand(long value) { this.bitand = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Sbyte {
    private long sbyte;

    @JsonProperty("sbyte")
    public long getSbyte() { return sbyte; }
    @JsonProperty("sbyte")
    public void setSbyte(long value) { this.sbyte = value; }
}

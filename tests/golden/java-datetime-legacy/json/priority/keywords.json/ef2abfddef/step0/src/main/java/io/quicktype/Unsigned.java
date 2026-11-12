package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Unsigned {
    private long unsigned;

    @JsonProperty("unsigned")
    public long getUnsigned() { return unsigned; }
    @JsonProperty("unsigned")
    public void setUnsigned(long value) { this.unsigned = value; }
}

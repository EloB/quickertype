package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Ulong {
    private long ulong;

    @JsonProperty("ulong")
    public long getUlong() { return ulong; }
    @JsonProperty("ulong")
    public void setUlong(long value) { this.ulong = value; }
}

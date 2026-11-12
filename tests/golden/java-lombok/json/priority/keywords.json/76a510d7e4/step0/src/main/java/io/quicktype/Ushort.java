package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Ushort {
    private long ushort;

    @JsonProperty("ushort")
    public long getUshort() { return ushort; }
    @JsonProperty("ushort")
    public void setUshort(long value) { this.ushort = value; }
}

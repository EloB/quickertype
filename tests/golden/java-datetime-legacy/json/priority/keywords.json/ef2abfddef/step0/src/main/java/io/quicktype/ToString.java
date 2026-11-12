package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ToString {
    private long toString;

    @JsonProperty("toString")
    public long getToString() { return toString; }
    @JsonProperty("toString")
    public void setToString(long value) { this.toString = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class NullClass {
    private long nullNull;

    @JsonProperty("null")
    public long getNullNull() { return nullNull; }
    @JsonProperty("null")
    public void setNullNull(long value) { this.nullNull = value; }
}

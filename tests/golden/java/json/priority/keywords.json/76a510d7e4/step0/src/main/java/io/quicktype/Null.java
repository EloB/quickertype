package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Null {
    private long nullNull;

    @JsonProperty("NULL")
    public long getNullNull() { return nullNull; }
    @JsonProperty("NULL")
    public void setNullNull(long value) { this.nullNull = value; }
}

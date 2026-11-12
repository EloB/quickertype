package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class LongClass {
    private long longLong;

    @JsonProperty("long")
    public long getLongLong() { return longLong; }
    @JsonProperty("long")
    public void setLongLong(long value) { this.longLong = value; }
}

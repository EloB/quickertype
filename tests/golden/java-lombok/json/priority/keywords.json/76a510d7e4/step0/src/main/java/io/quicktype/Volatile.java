package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Volatile {
    private long volatileVolatile;

    @JsonProperty("volatile")
    public long getVolatileVolatile() { return volatileVolatile; }
    @JsonProperty("volatile")
    public void setVolatileVolatile(long value) { this.volatileVolatile = value; }
}

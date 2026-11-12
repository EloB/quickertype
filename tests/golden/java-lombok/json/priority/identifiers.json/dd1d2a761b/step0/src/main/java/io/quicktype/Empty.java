package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Empty {
    private long x;

    @JsonProperty("x")
    public long getX() { return x; }
    @JsonProperty("x")
    public void setX(long value) { this.x = value; }
}

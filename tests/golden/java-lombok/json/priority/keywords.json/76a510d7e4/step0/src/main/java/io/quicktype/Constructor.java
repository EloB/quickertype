package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Constructor {
    private long constructor;

    @JsonProperty("constructor")
    public long getConstructor() { return constructor; }
    @JsonProperty("constructor")
    public void setConstructor(long value) { this.constructor = value; }
}

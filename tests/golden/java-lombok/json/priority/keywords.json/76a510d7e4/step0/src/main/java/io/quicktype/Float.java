package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Float {
    private long floatFloat;

    @JsonProperty("float")
    public long getFloatFloat() { return floatFloat; }
    @JsonProperty("float")
    public void setFloatFloat(long value) { this.floatFloat = value; }
}

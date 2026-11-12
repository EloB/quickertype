package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Any {
    private long any;

    @JsonProperty("Any")
    public long getAny() { return any; }
    @JsonProperty("Any")
    public void setAny(long value) { this.any = value; }
}

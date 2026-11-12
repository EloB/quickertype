package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class AnyClass {
    private long any;

    @JsonProperty("any")
    public long getAny() { return any; }
    @JsonProperty("any")
    public void setAny(long value) { this.any = value; }
}

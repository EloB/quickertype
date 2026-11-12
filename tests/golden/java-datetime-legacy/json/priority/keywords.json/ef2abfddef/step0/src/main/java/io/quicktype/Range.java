package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Range {
    private long range;

    @JsonProperty("range")
    public long getRange() { return range; }
    @JsonProperty("range")
    public void setRange(long value) { this.range = value; }
}

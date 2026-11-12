package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class OffsetTimeClass {
    private long offsetTime;

    @JsonProperty("OffsetTime")
    public long getOffsetTime() { return offsetTime; }
    @JsonProperty("OffsetTime")
    public void setOffsetTime(long value) { this.offsetTime = value; }
}

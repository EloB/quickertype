package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TimeOnly {
    private long timeOnly;

    @JsonProperty("TimeOnly")
    public long getTimeOnly() { return timeOnly; }
    @JsonProperty("TimeOnly")
    public void setTimeOnly(long value) { this.timeOnly = value; }
}

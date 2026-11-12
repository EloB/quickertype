package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TimeZone {
    private long timeZone;

    @JsonProperty("TimeZone")
    public long getTimeZone() { return timeZone; }
    @JsonProperty("TimeZone")
    public void setTimeZone(long value) { this.timeZone = value; }
}

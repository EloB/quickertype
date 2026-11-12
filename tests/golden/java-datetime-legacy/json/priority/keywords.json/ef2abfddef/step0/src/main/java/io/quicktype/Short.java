package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Short {
    private long shortShort;

    @JsonProperty("short")
    public long getShortShort() { return shortShort; }
    @JsonProperty("short")
    public void setShortShort(long value) { this.shortShort = value; }
}

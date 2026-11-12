package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TimeOnlyConverter {
    private long timeOnlyConverter;

    @JsonProperty("TimeOnlyConverter")
    public long getTimeOnlyConverter() { return timeOnlyConverter; }
    @JsonProperty("TimeOnlyConverter")
    public void setTimeOnlyConverter(long value) { this.timeOnlyConverter = value; }
}

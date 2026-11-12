package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DateOnly {
    private long dateOnly;

    @JsonProperty("DateOnly")
    public long getDateOnly() { return dateOnly; }
    @JsonProperty("DateOnly")
    public void setDateOnly(long value) { this.dateOnly = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DateFormatter {
    private long dateFormatter;

    @JsonProperty("DateFormatter")
    public long getDateFormatter() { return dateFormatter; }
    @JsonProperty("DateFormatter")
    public void setDateFormatter(long value) { this.dateFormatter = value; }
}

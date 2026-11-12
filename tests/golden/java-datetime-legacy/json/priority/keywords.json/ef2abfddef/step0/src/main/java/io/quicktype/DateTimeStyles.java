package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DateTimeStyles {
    private long dateTimeStyles;

    @JsonProperty("DateTimeStyles")
    public long getDateTimeStyles() { return dateTimeStyles; }
    @JsonProperty("DateTimeStyles")
    public void setDateTimeStyles(long value) { this.dateTimeStyles = value; }
}

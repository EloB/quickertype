package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Calendar {
    private long calendar;

    @JsonProperty("Calendar")
    public long getCalendar() { return calendar; }
    @JsonProperty("Calendar")
    public void setCalendar(long value) { this.calendar = value; }
}

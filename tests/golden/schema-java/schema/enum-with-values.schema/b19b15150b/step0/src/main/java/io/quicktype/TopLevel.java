package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Weekdays weekdays;

    @JsonProperty("weekdays")
    public Weekdays getWeekdays() { return weekdays; }
    @JsonProperty("weekdays")
    public void setWeekdays(Weekdays value) { this.weekdays = value; }
}

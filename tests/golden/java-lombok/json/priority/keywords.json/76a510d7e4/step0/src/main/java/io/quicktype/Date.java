package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Date {
    private long date;

    @JsonProperty("date")
    public long getDate() { return date; }
    @JsonProperty("date")
    public void setDate(long value) { this.date = value; }
}

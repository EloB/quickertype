package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DateParseHandling {
    private long dateParseHandling;

    @JsonProperty("date_parse_handling")
    public long getDateParseHandling() { return dateParseHandling; }
    @JsonProperty("date_parse_handling")
    public void setDateParseHandling(long value) { this.dateParseHandling = value; }
}

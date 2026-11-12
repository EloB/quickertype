package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class LocalDate {
    private long localDate;

    @JsonProperty("LocalDate")
    public long getLocalDate() { return localDate; }
    @JsonProperty("LocalDate")
    public void setLocalDate(long value) { this.localDate = value; }
}

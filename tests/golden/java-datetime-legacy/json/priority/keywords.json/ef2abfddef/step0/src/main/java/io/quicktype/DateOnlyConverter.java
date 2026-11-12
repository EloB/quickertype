package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DateOnlyConverter {
    private long dateOnlyConverter;

    @JsonProperty("DateOnlyConverter")
    public long getDateOnlyConverter() { return dateOnlyConverter; }
    @JsonProperty("DateOnlyConverter")
    public void setDateOnlyConverter(long value) { this.dateOnlyConverter = value; }
}

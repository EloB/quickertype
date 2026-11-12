package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;

public class DateTime {
    private OffsetDateTime dateTime;

    @JsonProperty("DateTime")
    public OffsetDateTime getDateTime() { return dateTime; }
    @JsonProperty("DateTime")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setDateTime(OffsetDateTime value) { this.dateTime = value; }
}

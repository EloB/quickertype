package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class OffsetDateTime {
    private long offsetDateTime;

    @JsonProperty("OffsetDateTime")
    public long getOffsetDateTime() { return offsetDateTime; }
    @JsonProperty("OffsetDateTime")
    public void setOffsetDateTime(long value) { this.offsetDateTime = value; }
}

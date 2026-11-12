package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ISODateTimeOffsetConverter {
    private long isoDateTimeOffsetConverter;

    @JsonProperty("IsoDateTimeOffsetConverter")
    public long getISODateTimeOffsetConverter() { return isoDateTimeOffsetConverter; }
    @JsonProperty("IsoDateTimeOffsetConverter")
    public void setISODateTimeOffsetConverter(long value) { this.isoDateTimeOffsetConverter = value; }
}

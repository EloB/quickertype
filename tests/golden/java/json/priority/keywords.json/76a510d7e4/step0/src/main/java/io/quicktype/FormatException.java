package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class FormatException {
    private long formatException;

    @JsonProperty("FormatException")
    public long getFormatException() { return formatException; }
    @JsonProperty("FormatException")
    public void setFormatException(long value) { this.formatException = value; }
}

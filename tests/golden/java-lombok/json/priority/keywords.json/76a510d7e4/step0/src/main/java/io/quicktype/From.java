package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class From {
    private long from;

    @JsonProperty("from")
    public long getFrom() { return from; }
    @JsonProperty("from")
    public void setFrom(long value) { this.from = value; }
}

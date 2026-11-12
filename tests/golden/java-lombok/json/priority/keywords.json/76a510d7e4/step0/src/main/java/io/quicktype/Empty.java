package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Empty {
    private long empty;

    @JsonProperty("_")
    public long getEmpty() { return empty; }
    @JsonProperty("_")
    public void setEmpty(long value) { this.empty = value; }
}

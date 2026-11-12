package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Exposing {
    private long exposing;

    @JsonProperty("exposing")
    public long getExposing() { return exposing; }
    @JsonProperty("exposing")
    public void setExposing(long value) { this.exposing = value; }
}

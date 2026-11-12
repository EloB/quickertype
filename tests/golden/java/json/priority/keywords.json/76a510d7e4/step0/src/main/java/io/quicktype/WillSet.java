package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class WillSet {
    private long willSet;

    @JsonProperty("willSet")
    public long getWillSet() { return willSet; }
    @JsonProperty("willSet")
    public void setWillSet(long value) { this.willSet = value; }
}

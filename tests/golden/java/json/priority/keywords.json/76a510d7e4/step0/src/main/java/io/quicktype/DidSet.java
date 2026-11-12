package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DidSet {
    private long didSet;

    @JsonProperty("didSet")
    public long getDidSet() { return didSet; }
    @JsonProperty("didSet")
    public void setDidSet(long value) { this.didSet = value; }
}

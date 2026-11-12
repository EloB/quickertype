package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Oneway {
    private long oneway;

    @JsonProperty("oneway")
    public long getOneway() { return oneway; }
    @JsonProperty("oneway")
    public void setOneway(long value) { this.oneway = value; }
}

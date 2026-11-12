package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class In {
    private long in;

    @JsonProperty("in")
    public long getIn() { return in; }
    @JsonProperty("in")
    public void setIn(long value) { this.in = value; }
}

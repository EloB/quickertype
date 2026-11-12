package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Retain {
    private long retain;

    @JsonProperty("retain")
    public long getRetain() { return retain; }
    @JsonProperty("retain")
    public void setRetain(long value) { this.retain = value; }
}

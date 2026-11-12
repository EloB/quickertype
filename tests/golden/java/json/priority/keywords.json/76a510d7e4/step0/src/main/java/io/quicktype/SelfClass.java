package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class SelfClass {
    private long self;

    @JsonProperty("self")
    public long getSelf() { return self; }
    @JsonProperty("self")
    public void setSelf(long value) { this.self = value; }
}

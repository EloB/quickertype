package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Self {
    private long self;

    @JsonProperty("Self")
    public long getSelf() { return self; }
    @JsonProperty("Self")
    public void setSelf(long value) { this.self = value; }
}

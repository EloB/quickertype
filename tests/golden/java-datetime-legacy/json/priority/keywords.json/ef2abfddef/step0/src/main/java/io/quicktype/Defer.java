package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Defer {
    private long defer;

    @JsonProperty("defer")
    public long getDefer() { return defer; }
    @JsonProperty("defer")
    public void setDefer(long value) { this.defer = value; }
}

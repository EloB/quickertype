package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Init {
    private long init;

    @JsonProperty("init")
    public long getInit() { return init; }
    @JsonProperty("init")
    public void setInit(long value) { this.init = value; }
}

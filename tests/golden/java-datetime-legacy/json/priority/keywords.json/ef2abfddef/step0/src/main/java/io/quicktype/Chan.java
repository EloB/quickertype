package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Chan {
    private long chan;

    @JsonProperty("chan")
    public long getChan() { return chan; }
    @JsonProperty("chan")
    public void setChan(long value) { this.chan = value; }
}

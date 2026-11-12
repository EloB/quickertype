package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Global {
    private long global;

    @JsonProperty("global")
    public long getGlobal() { return global; }
    @JsonProperty("global")
    public void setGlobal(long value) { this.global = value; }
}

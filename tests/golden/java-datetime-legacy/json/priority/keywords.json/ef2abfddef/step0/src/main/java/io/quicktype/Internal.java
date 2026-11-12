package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Internal {
    private long internal;

    @JsonProperty("internal")
    public long getInternal() { return internal; }
    @JsonProperty("internal")
    public void setInternal(long value) { this.internal = value; }
}

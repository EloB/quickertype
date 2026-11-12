package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Protocol {
    private long protocol;

    @JsonProperty("Protocol")
    public long getProtocol() { return protocol; }
    @JsonProperty("Protocol")
    public void setProtocol(long value) { this.protocol = value; }
}

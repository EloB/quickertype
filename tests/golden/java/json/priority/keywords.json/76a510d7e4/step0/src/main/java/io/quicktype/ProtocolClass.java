package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ProtocolClass {
    private long protocol;

    @JsonProperty("protocol")
    public long getProtocol() { return protocol; }
    @JsonProperty("protocol")
    public void setProtocol(long value) { this.protocol = value; }
}

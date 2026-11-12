package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Port {
    private long port;

    @JsonProperty("port")
    public long getPort() { return port; }
    @JsonProperty("port")
    public void setPort(long value) { this.port = value; }
}

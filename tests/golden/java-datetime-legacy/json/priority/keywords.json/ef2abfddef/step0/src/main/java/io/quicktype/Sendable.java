package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Sendable {
    private long sendable;

    @JsonProperty("Sendable")
    public long getSendable() { return sendable; }
    @JsonProperty("Sendable")
    public void setSendable(long value) { this.sendable = value; }
}

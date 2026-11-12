package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Serialize {
    private long serialize;

    @JsonProperty("serialize")
    public long getSerialize() { return serialize; }
    @JsonProperty("serialize")
    public void setSerialize(long value) { this.serialize = value; }
}

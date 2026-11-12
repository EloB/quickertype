package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class UUIDClass {
    private long uuid;

    @JsonProperty("UUID")
    public long getUUID() { return uuid; }
    @JsonProperty("UUID")
    public void setUUID(long value) { this.uuid = value; }
}

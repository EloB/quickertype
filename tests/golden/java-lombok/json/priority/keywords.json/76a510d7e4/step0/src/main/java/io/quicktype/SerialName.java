package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class SerialName {
    private long serialName;

    @JsonProperty("SerialName")
    public long getSerialName() { return serialName; }
    @JsonProperty("SerialName")
    public void setSerialName(long value) { this.serialName = value; }
}

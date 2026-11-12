package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class SerialDescriptor {
    private long serialDescriptor;

    @JsonProperty("SerialDescriptor")
    public long getSerialDescriptor() { return serialDescriptor; }
    @JsonProperty("SerialDescriptor")
    public void setSerialDescriptor(long value) { this.serialDescriptor = value; }
}

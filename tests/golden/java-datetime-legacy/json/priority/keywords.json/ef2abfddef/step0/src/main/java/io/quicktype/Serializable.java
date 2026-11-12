package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Serializable {
    private long serializable;

    @JsonProperty("Serializable")
    public long getSerializable() { return serializable; }
    @JsonProperty("Serializable")
    public void setSerializable(long value) { this.serializable = value; }
}

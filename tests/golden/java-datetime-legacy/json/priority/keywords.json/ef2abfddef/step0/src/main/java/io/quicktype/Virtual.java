package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Virtual {
    private long virtual;

    @JsonProperty("virtual")
    public long getVirtual() { return virtual; }
    @JsonProperty("virtual")
    public void setVirtual(long value) { this.virtual = value; }
}

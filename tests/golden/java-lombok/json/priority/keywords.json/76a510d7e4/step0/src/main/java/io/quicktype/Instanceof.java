package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Instanceof {
    private long instanceofInstanceof;

    @JsonProperty("instanceof")
    public long getInstanceofInstanceof() { return instanceofInstanceof; }
    @JsonProperty("instanceof")
    public void setInstanceofInstanceof(long value) { this.instanceofInstanceof = value; }
}

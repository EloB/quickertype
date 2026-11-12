package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Clone {
    private long clone;

    @JsonProperty("clone")
    public long getClone() { return clone; }
    @JsonProperty("clone")
    public void setClone(long value) { this.clone = value; }
}

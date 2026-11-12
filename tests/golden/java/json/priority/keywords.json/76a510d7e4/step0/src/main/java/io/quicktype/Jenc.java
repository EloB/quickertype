package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Jenc {
    private long jenc;

    @JsonProperty("jenc")
    public long getJenc() { return jenc; }
    @JsonProperty("jenc")
    public void setJenc(long value) { this.jenc = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Union {
    private long union;

    @JsonProperty("union")
    public long getUnion() { return union; }
    @JsonProperty("union")
    public void setUnion(long value) { this.union = value; }
}

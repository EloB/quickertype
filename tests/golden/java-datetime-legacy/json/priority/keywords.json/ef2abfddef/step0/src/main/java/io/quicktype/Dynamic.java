package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Dynamic {
    private long dynamic;

    @JsonProperty("dynamic")
    public long getDynamic() { return dynamic; }
    @JsonProperty("dynamic")
    public void setDynamic(long value) { this.dynamic = value; }
}

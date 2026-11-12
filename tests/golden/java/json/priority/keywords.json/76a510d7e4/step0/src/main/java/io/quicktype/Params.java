package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Params {
    private long params;

    @JsonProperty("params")
    public long getParams() { return params; }
    @JsonProperty("params")
    public void setParams(long value) { this.params = value; }
}

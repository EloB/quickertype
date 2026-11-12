package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Unchecked {
    private long unchecked;

    @JsonProperty("unchecked")
    public long getUnchecked() { return unchecked; }
    @JsonProperty("unchecked")
    public void setUnchecked(long value) { this.unchecked = value; }
}

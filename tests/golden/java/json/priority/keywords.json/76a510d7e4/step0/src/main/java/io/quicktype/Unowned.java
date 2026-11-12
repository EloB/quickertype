package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Unowned {
    private long unowned;

    @JsonProperty("unowned")
    public long getUnowned() { return unowned; }
    @JsonProperty("unowned")
    public void setUnowned(long value) { this.unowned = value; }
}

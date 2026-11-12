package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class This {
    private long thisThis;

    @JsonProperty("this")
    public long getThisThis() { return thisThis; }
    @JsonProperty("this")
    public void setThisThis(long value) { this.thisThis = value; }
}

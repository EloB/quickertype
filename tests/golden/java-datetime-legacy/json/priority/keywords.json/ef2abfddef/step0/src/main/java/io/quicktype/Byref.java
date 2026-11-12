package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Byref {
    private long byref;

    @JsonProperty("byref")
    public long getByref() { return byref; }
    @JsonProperty("byref")
    public void setByref(long value) { this.byref = value; }
}

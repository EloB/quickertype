package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DynamicCast {
    private long dynamicCast;

    @JsonProperty("dynamic_cast")
    public long getDynamicCast() { return dynamicCast; }
    @JsonProperty("dynamic_cast")
    public void setDynamicCast(long value) { this.dynamicCast = value; }
}

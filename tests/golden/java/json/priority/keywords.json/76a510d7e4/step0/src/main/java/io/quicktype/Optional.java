package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Optional {
    private long optional;

    @JsonProperty("optional")
    public long getOptional() { return optional; }
    @JsonProperty("optional")
    public void setOptional(long value) { this.optional = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Implicit {
    private long implicit;

    @JsonProperty("implicit")
    public long getImplicit() { return implicit; }
    @JsonProperty("implicit")
    public void setImplicit(long value) { this.implicit = value; }
}

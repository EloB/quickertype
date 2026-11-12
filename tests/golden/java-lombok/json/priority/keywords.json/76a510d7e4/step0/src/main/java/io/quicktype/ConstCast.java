package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ConstCast {
    private long constCast;

    @JsonProperty("const_cast")
    public long getConstCast() { return constCast; }
    @JsonProperty("const_cast")
    public void setConstCast(long value) { this.constCast = value; }
}

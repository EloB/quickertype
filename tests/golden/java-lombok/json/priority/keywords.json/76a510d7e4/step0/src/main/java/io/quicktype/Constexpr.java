package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Constexpr {
    private long constexpr;

    @JsonProperty("constexpr")
    public long getConstexpr() { return constexpr; }
    @JsonProperty("constexpr")
    public void setConstexpr(long value) { this.constexpr = value; }
}

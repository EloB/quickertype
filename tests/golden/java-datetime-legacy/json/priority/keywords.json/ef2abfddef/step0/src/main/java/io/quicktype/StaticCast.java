package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class StaticCast {
    private long staticCast;

    @JsonProperty("static_cast")
    public long getStaticCast() { return staticCast; }
    @JsonProperty("static_cast")
    public void setStaticCast(long value) { this.staticCast = value; }
}

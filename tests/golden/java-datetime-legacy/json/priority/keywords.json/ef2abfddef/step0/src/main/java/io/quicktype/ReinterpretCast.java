package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ReinterpretCast {
    private long reinterpretCast;

    @JsonProperty("reinterpret_cast")
    public long getReinterpretCast() { return reinterpretCast; }
    @JsonProperty("reinterpret_cast")
    public void setReinterpretCast(long value) { this.reinterpretCast = value; }
}

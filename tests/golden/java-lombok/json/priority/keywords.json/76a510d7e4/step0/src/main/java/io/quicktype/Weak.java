package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Weak {
    private long weak;

    @JsonProperty("weak")
    public long getWeak() { return weak; }
    @JsonProperty("weak")
    public void setWeak(long value) { this.weak = value; }
}

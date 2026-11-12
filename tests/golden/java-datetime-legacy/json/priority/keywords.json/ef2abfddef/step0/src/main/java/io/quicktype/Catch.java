package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Catch {
    private long catchCatch;

    @JsonProperty("catch")
    public long getCatchCatch() { return catchCatch; }
    @JsonProperty("catch")
    public void setCatchCatch(long value) { this.catchCatch = value; }
}

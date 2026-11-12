package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Guard {
    private long guard;

    @JsonProperty("guard")
    public long getGuard() { return guard; }
    @JsonProperty("guard")
    public void setGuard(long value) { this.guard = value; }
}

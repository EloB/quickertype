package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Raise {
    private long raise;

    @JsonProperty("raise")
    public long getRaise() { return raise; }
    @JsonProperty("raise")
    public void setRaise(long value) { this.raise = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Convenience {
    private long convenience;

    @JsonProperty("convenience")
    public long getConvenience() { return convenience; }
    @JsonProperty("convenience")
    public void setConvenience(long value) { this.convenience = value; }
}

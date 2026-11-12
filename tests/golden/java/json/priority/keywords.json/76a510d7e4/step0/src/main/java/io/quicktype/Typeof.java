package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Typeof {
    private long typeof;

    @JsonProperty("typeof")
    public long getTypeof() { return typeof; }
    @JsonProperty("typeof")
    public void setTypeof(long value) { this.typeof = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Then {
    private long then;

    @JsonProperty("then")
    public long getThen() { return then; }
    @JsonProperty("then")
    public void setThen(long value) { this.then = value; }
}

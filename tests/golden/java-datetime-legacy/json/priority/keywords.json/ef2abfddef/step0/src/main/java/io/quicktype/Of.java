package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Of {
    private long of;

    @JsonProperty("of")
    public long getOf() { return of; }
    @JsonProperty("of")
    public void setOf(long value) { this.of = value; }
}

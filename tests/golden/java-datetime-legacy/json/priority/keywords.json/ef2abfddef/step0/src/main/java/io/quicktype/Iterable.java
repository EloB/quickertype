package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Iterable {
    private long iterable;

    @JsonProperty("iterable")
    public long getIterable() { return iterable; }
    @JsonProperty("iterable")
    public void setIterable(long value) { this.iterable = value; }
}

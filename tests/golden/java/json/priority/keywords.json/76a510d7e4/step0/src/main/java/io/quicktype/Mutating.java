package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Mutating {
    private long mutating;

    @JsonProperty("mutating")
    public long getMutating() { return mutating; }
    @JsonProperty("mutating")
    public void setMutating(long value) { this.mutating = value; }
}

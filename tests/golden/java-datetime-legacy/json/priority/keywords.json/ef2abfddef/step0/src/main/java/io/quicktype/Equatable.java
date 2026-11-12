package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Equatable {
    private long equatable;

    @JsonProperty("Equatable")
    public long getEquatable() { return equatable; }
    @JsonProperty("Equatable")
    public void setEquatable(long value) { this.equatable = value; }
}

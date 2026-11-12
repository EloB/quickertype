package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Atomic {
    private long atomic;

    @JsonProperty("atomic")
    public long getAtomic() { return atomic; }
    @JsonProperty("atomic")
    public void setAtomic(long value) { this.atomic = value; }
}

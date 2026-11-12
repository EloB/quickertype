package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Lock {
    private long lock;

    @JsonProperty("lock")
    public long getLock() { return lock; }
    @JsonProperty("lock")
    public void setLock(long value) { this.lock = value; }
}

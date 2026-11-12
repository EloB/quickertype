package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class AtomicCancel {
    private long atomicCancel;

    @JsonProperty("atomic_cancel")
    public long getAtomicCancel() { return atomicCancel; }
    @JsonProperty("atomic_cancel")
    public void setAtomicCancel(long value) { this.atomicCancel = value; }
}

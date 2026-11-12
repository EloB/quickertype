package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class AtomicCommit {
    private long atomicCommit;

    @JsonProperty("atomic_commit")
    public long getAtomicCommit() { return atomicCommit; }
    @JsonProperty("atomic_commit")
    public void setAtomicCommit(long value) { this.atomicCommit = value; }
}

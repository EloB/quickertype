package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class AtomicNoexcept {
    private long atomicNoexcept;

    @JsonProperty("atomic_noexcept")
    public long getAtomicNoexcept() { return atomicNoexcept; }
    @JsonProperty("atomic_noexcept")
    public void setAtomicNoexcept(long value) { this.atomicNoexcept = value; }
}

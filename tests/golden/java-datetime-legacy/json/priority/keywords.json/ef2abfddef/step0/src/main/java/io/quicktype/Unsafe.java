package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Unsafe {
    private long unsafe;

    @JsonProperty("unsafe")
    public long getUnsafe() { return unsafe; }
    @JsonProperty("unsafe")
    public void setUnsafe(long value) { this.unsafe = value; }
}

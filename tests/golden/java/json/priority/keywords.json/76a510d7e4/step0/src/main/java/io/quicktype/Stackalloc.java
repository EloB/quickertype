package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Stackalloc {
    private long stackalloc;

    @JsonProperty("stackalloc")
    public long getStackalloc() { return stackalloc; }
    @JsonProperty("stackalloc")
    public void setStackalloc(long value) { this.stackalloc = value; }
}

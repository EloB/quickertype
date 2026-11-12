package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Char16T {
    private long char16T;

    @JsonProperty("char16_t")
    public long getChar16T() { return char16T; }
    @JsonProperty("char16_t")
    public void setChar16T(long value) { this.char16T = value; }
}

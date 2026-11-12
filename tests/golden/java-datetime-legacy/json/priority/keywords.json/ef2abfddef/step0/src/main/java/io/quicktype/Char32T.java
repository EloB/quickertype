package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Char32T {
    private long char32T;

    @JsonProperty("char32_t")
    public long getChar32T() { return char32T; }
    @JsonProperty("char32_t")
    public void setChar32T(long value) { this.char32T = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class BoolClass {
    private long bool;

    @JsonProperty("_Bool")
    public long getBool() { return bool; }
    @JsonProperty("_Bool")
    public void setBool(long value) { this.bool = value; }
}

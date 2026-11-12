package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Bool {
    private long bool;

    @JsonProperty("BOOL")
    public long getBool() { return bool; }
    @JsonProperty("BOOL")
    public void setBool(long value) { this.bool = value; }
}

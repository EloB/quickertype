package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Obj1Bool {
    private long bool;

    @JsonProperty("bool")
    public long getBool() { return bool; }
    @JsonProperty("bool")
    public void setBool(long value) { this.bool = value; }
}

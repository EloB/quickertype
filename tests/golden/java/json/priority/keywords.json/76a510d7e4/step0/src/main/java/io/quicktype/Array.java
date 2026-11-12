package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Array {
    private long array;

    @JsonProperty("array")
    public long getArray() { return array; }
    @JsonProperty("array")
    public void setArray(long value) { this.array = value; }
}

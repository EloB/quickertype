package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Sizeof {
    private long sizeof;

    @JsonProperty("sizeof")
    public long getSizeof() { return sizeof; }
    @JsonProperty("sizeof")
    public void setSizeof(long value) { this.sizeof = value; }
}

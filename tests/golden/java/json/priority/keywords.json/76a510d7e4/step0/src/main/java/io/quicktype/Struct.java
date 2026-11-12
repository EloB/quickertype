package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Struct {
    private long struct;

    @JsonProperty("struct")
    public long getStruct() { return struct; }
    @JsonProperty("struct")
    public void setStruct(long value) { this.struct = value; }
}

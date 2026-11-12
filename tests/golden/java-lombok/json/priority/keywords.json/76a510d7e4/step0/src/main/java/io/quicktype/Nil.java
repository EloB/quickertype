package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Nil {
    private long nil;

    @JsonProperty("nil")
    public long getNil() { return nil; }
    @JsonProperty("nil")
    public void setNil(long value) { this.nil = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Ref {
    private long ref;

    @JsonProperty("ref")
    public long getRef() { return ref; }
    @JsonProperty("ref")
    public void setRef(long value) { this.ref = value; }
}

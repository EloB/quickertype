package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Associatedtype {
    private long associatedtype;

    @JsonProperty("associatedtype")
    public long getAssociatedtype() { return associatedtype; }
    @JsonProperty("associatedtype")
    public void setAssociatedtype(long value) { this.associatedtype = value; }
}

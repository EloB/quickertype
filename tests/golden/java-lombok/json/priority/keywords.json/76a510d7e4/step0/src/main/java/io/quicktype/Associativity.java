package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Associativity {
    private long associativity;

    @JsonProperty("associativity")
    public long getAssociativity() { return associativity; }
    @JsonProperty("associativity")
    public void setAssociativity(long value) { this.associativity = value; }
}

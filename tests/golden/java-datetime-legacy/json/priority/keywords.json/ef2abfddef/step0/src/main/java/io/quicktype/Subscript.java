package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Subscript {
    private long subscript;

    @JsonProperty("subscript")
    public long getSubscript() { return subscript; }
    @JsonProperty("subscript")
    public void setSubscript(long value) { this.subscript = value; }
}

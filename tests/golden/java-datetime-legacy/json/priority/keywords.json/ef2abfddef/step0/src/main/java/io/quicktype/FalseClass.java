package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class FalseClass {
    private long falseFalse;

    @JsonProperty("false")
    public long getFalseFalse() { return falseFalse; }
    @JsonProperty("false")
    public void setFalseFalse(long value) { this.falseFalse = value; }
}

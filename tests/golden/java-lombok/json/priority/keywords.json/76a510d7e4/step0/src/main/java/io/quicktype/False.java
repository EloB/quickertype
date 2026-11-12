package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class False {
    private long falseFalse;

    @JsonProperty("False")
    public long getFalseFalse() { return falseFalse; }
    @JsonProperty("False")
    public void setFalseFalse(long value) { this.falseFalse = value; }
}

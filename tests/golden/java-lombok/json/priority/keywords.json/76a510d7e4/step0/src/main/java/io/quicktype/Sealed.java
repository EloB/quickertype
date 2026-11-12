package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Sealed {
    private long sealed;

    @JsonProperty("sealed")
    public long getSealed() { return sealed; }
    @JsonProperty("sealed")
    public void setSealed(long value) { this.sealed = value; }
}

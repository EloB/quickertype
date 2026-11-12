package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Undefined {
    private long undefined;

    @JsonProperty("undefined")
    public long getUndefined() { return undefined; }
    @JsonProperty("undefined")
    public void setUndefined(long value) { this.undefined = value; }
}

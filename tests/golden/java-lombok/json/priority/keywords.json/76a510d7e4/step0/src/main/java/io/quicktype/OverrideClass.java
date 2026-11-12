package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class OverrideClass {
    private long override;

    @JsonProperty("override")
    public long getOverride() { return override; }
    @JsonProperty("override")
    public void setOverride(long value) { this.override = value; }
}

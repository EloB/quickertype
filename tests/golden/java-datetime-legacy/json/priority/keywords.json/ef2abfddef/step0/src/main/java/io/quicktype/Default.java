package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Default {
    private long defaultDefault;

    @JsonProperty("default")
    public long getDefaultDefault() { return defaultDefault; }
    @JsonProperty("default")
    public void setDefaultDefault(long value) { this.defaultDefault = value; }
}

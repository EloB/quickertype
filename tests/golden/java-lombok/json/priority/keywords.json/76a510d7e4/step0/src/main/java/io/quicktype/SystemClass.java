package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class SystemClass {
    private long system;

    @JsonProperty("system")
    public long getSystem() { return system; }
    @JsonProperty("system")
    public void setSystem(long value) { this.system = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Debugger {
    private long debugger;

    @JsonProperty("debugger")
    public long getDebugger() { return debugger; }
    @JsonProperty("debugger")
    public void setDebugger(long value) { this.debugger = value; }
}

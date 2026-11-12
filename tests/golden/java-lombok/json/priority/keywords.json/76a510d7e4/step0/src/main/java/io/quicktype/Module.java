package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Module {
    private long module;

    @JsonProperty("module")
    public long getModule() { return module; }
    @JsonProperty("module")
    public void setModule(long value) { this.module = value; }
}

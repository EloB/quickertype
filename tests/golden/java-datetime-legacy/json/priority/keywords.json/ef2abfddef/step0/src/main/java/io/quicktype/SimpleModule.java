package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class SimpleModule {
    private long simpleModule;

    @JsonProperty("SimpleModule")
    public long getSimpleModule() { return simpleModule; }
    @JsonProperty("SimpleModule")
    public void setSimpleModule(long value) { this.simpleModule = value; }
}

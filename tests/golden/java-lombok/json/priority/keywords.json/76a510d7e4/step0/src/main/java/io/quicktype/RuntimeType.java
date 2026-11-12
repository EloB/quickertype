package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class RuntimeType {
    private long runtimeType;

    @JsonProperty("runtimeType")
    public long getRuntimeType() { return runtimeType; }
    @JsonProperty("runtimeType")
    public void setRuntimeType(long value) { this.runtimeType = value; }
}

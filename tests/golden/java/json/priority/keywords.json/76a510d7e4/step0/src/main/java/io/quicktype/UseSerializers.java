package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class UseSerializers {
    private long useSerializers;

    @JsonProperty("UseSerializers")
    public long getUseSerializers() { return useSerializers; }
    @JsonProperty("UseSerializers")
    public void setUseSerializers(long value) { this.useSerializers = value; }
}

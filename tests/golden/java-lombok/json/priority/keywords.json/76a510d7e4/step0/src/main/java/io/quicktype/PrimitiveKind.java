package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class PrimitiveKind {
    private long primitiveKind;

    @JsonProperty("PrimitiveKind")
    public long getPrimitiveKind() { return primitiveKind; }
    @JsonProperty("PrimitiveKind")
    public void setPrimitiveKind(long value) { this.primitiveKind = value; }
}

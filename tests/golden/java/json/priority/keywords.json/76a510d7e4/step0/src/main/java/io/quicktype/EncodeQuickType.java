package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class EncodeQuickType {
    private long encodeQuickType;

    @JsonProperty("encode_quick_type")
    public long getEncodeQuickType() { return encodeQuickType; }
    @JsonProperty("encode_quick_type")
    public void setEncodeQuickType(long value) { this.encodeQuickType = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Native {
    private long nativeNative;

    @JsonProperty("native")
    public long getNativeNative() { return nativeNative; }
    @JsonProperty("native")
    public void setNativeNative(long value) { this.nativeNative = value; }
}

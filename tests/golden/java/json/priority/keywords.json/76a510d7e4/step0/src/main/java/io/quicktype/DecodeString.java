package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DecodeString {
    private long decodeString;

    @JsonProperty("decode_string")
    public long getDecodeString() { return decodeString; }
    @JsonProperty("decode_string")
    public void setDecodeString(long value) { this.decodeString = value; }
}

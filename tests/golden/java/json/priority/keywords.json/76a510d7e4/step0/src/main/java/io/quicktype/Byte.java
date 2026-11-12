package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Byte {
    private long byteByte;

    @JsonProperty("byte")
    public long getByteByte() { return byteByte; }
    @JsonProperty("byte")
    public void setByteByte(long value) { this.byteByte = value; }
}

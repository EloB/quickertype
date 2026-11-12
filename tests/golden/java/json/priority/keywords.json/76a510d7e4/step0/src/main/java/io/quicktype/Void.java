package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Void {
    private long voidVoid;

    @JsonProperty("void")
    public long getVoidVoid() { return voidVoid; }
    @JsonProperty("void")
    public void setVoidVoid(long value) { this.voidVoid = value; }
}

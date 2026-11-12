package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Extern {
    private long extern;

    @JsonProperty("extern")
    public long getExtern() { return extern; }
    @JsonProperty("extern")
    public void setExtern(long value) { this.extern = value; }
}

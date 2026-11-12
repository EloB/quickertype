package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Sel {
    private long sel;

    @JsonProperty("SEL")
    public long getSel() { return sel; }
    @JsonProperty("SEL")
    public void setSel(long value) { this.sel = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Def {
    private long def;

    @JsonProperty("def")
    public long getDef() { return def; }
    @JsonProperty("def")
    public void setDef(long value) { this.def = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Const {
    private long constConst;

    @JsonProperty("const")
    public long getConstConst() { return constConst; }
    @JsonProperty("const")
    public void setConstConst(long value) { this.constConst = value; }
}

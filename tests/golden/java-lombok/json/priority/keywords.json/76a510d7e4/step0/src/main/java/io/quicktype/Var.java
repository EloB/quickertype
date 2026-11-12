package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Var {
    private long var;

    @JsonProperty("var")
    public long getVar() { return var; }
    @JsonProperty("var")
    public void setVar(long value) { this.var = value; }
}

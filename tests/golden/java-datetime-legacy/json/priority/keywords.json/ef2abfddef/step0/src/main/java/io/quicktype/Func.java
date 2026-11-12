package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Func {
    private long func;

    @JsonProperty("func")
    public long getFunc() { return func; }
    @JsonProperty("func")
    public void setFunc(long value) { this.func = value; }
}

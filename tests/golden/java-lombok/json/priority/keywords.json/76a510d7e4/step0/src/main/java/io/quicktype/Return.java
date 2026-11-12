package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Return {
    private long returnReturn;

    @JsonProperty("return")
    public long getReturnReturn() { return returnReturn; }
    @JsonProperty("return")
    public void setReturnReturn(long value) { this.returnReturn = value; }
}

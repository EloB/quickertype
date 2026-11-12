package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class CoReturn {
    private long coReturn;

    @JsonProperty("co_return")
    public long getCoReturn() { return coReturn; }
    @JsonProperty("co_return")
    public void setCoReturn(long value) { this.coReturn = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Function {
    private long function;

    @JsonProperty("function")
    public long getFunction() { return function; }
    @JsonProperty("function")
    public void setFunction(long value) { this.function = value; }
}

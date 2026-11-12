package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class BooleanClass {
    private long booleanBoolean;

    @JsonProperty("boolean")
    public long getBooleanBoolean() { return booleanBoolean; }
    @JsonProperty("boolean")
    public void setBooleanBoolean(long value) { this.booleanBoolean = value; }
}

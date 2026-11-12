package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Int {
    private long intInt;

    @JsonProperty("int")
    public long getIntInt() { return intInt; }
    @JsonProperty("int")
    public void setIntInt(long value) { this.intInt = value; }
}

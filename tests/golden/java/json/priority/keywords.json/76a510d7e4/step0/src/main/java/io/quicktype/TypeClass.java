package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TypeClass {
    private long type;

    @JsonProperty("type")
    public long getType() { return type; }
    @JsonProperty("type")
    public void setType(long value) { this.type = value; }
}

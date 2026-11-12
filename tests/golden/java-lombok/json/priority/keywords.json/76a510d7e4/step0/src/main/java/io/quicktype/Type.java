package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Type {
    private long type;

    @JsonProperty("Type")
    public long getType() { return type; }
    @JsonProperty("Type")
    public void setType(long value) { this.type = value; }
}

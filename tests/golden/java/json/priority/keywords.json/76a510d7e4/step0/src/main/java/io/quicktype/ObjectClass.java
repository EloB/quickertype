package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ObjectClass {
    private long object;

    @JsonProperty("object")
    public long getObject() { return object; }
    @JsonProperty("object")
    public void setObject(long value) { this.object = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Enum {
    private long enumEnum;

    @JsonProperty("enum")
    public long getEnumEnum() { return enumEnum; }
    @JsonProperty("enum")
    public void setEnumEnum(long value) { this.enumEnum = value; }
}

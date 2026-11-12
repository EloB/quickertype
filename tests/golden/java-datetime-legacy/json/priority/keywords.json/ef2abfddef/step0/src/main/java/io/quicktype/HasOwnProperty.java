package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class HasOwnProperty {
    private long hasOwnProperty;

    @JsonProperty("hasOwnProperty")
    public long getHasOwnProperty() { return hasOwnProperty; }
    @JsonProperty("hasOwnProperty")
    public void setHasOwnProperty(long value) { this.hasOwnProperty = value; }
}

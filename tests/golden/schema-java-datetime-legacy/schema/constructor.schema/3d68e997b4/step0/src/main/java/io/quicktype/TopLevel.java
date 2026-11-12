package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private UnionConstructor constructor;

    @JsonProperty("constructor")
    public UnionConstructor getConstructor() { return constructor; }
    @JsonProperty("constructor")
    public void setConstructor(UnionConstructor value) { this.constructor = value; }
}

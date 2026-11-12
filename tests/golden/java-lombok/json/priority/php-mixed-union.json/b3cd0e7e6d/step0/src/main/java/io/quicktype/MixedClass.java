package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class MixedClass {
    private String nested;

    @JsonProperty("nested")
    public String getNested() { return nested; }
    @JsonProperty("nested")
    public void setNested(String value) { this.nested = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class UnionClass {
    private Long quux;

    @JsonProperty("quux")
    public Long getQuux() { return quux; }
    @JsonProperty("quux")
    public void setQuux(Long value) { this.quux = value; }
}

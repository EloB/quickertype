package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Map;

public class TopLevel {
    private Map<String, Double> foo;

    @JsonProperty("foo")
    public Map<String, Double> getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(Map<String, Double> value) { this.foo = value; }
}

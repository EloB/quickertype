package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Map;

public class TopLevel {
    private Map<String, Long> a;
    private Map<String, Long> b;

    @JsonProperty("a")
    public Map<String, Long> getA() { return a; }
    @JsonProperty("a")
    public void setA(Map<String, Long> value) { this.a = value; }

    @JsonProperty("b")
    public Map<String, Long> getB() { return b; }
    @JsonProperty("b")
    public void setB(Map<String, Long> value) { this.b = value; }
}

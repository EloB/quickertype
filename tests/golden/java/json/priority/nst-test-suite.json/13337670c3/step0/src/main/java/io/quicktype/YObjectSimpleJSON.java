package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class YObjectSimpleJSON {
    private List<Object> a;

    @JsonProperty("a")
    public List<Object> getA() { return a; }
    @JsonProperty("a")
    public void setA(List<Object> value) { this.a = value; }
}

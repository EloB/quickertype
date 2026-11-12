package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Bar> bar;
    private List<Bar> foo;

    @JsonProperty("bar")
    public List<Bar> getBar() { return bar; }
    @JsonProperty("bar")
    public void setBar(List<Bar> value) { this.bar = value; }

    @JsonProperty("foo")
    public List<Bar> getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(List<Bar> value) { this.foo = value; }
}

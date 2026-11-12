package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Foo> foo;

    @JsonProperty("foo")
    public List<Foo> getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(List<Foo> value) { this.foo = value; }
}

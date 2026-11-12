package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private FooUnion foo;

    @JsonProperty("foo")
    public FooUnion getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(FooUnion value) { this.foo = value; }
}

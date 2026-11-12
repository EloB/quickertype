package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Bar {
    private Foo foo;

    @JsonProperty("foo")
    public Foo getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(Foo value) { this.foo = value; }
}

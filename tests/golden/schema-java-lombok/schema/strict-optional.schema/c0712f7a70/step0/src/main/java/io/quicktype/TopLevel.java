package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Double foo;

    @JsonProperty("foo")
    public Double getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(Double value) { this.foo = value; }
}

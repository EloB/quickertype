package io.quicktype;

import com.fasterxml.jackson.annotation.*;

/**
 * Cool "stuff"
 */
public class TopLevel {
    private Boolean foo;

    @JsonProperty("foo")
    public Boolean getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(Boolean value) { this.foo = value; }
}

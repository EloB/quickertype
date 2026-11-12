package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private long foo;

    @JsonProperty("foo")
    public long getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(long value) { this.foo = value; }
}

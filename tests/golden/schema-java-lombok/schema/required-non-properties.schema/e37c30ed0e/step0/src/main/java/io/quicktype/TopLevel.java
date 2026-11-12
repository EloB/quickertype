package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private long foo;
    private Object bar;

    @JsonProperty("foo")
    public long getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(long value) { this.foo = value; }

    @JsonProperty("bar")
    public Object getBar() { return bar; }
    @JsonProperty("bar")
    public void setBar(Object value) { this.bar = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private boolean bar;
    private Object foo;

    @JsonProperty("bar")
    public boolean getBar() { return bar; }
    @JsonProperty("bar")
    public void setBar(boolean value) { this.bar = value; }

    @JsonProperty("foo")
    public Object getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(Object value) { this.foo = value; }
}

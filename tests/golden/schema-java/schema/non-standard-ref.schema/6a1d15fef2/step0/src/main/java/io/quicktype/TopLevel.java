package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private long bar;
    private long foo;
    private boolean quux;

    @JsonProperty("bar")
    public long getBar() { return bar; }
    @JsonProperty("bar")
    public void setBar(long value) { this.bar = value; }

    @JsonProperty("foo")
    public long getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(long value) { this.foo = value; }

    @JsonProperty("quux")
    public boolean getQuux() { return quux; }
    @JsonProperty("quux")
    public void setQuux(boolean value) { this.quux = value; }
}

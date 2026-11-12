package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private long foo;
    private boolean bar;
    private String quux;

    @JsonProperty("foo")
    public long getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(long value) { this.foo = value; }

    @JsonProperty("bar")
    public boolean getBar() { return bar; }
    @JsonProperty("bar")
    public void setBar(boolean value) { this.bar = value; }

    @JsonProperty("quux")
    public String getQuux() { return quux; }
    @JsonProperty("quux")
    public void setQuux(String value) { this.quux = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Foo {
    private FooBla bla;
    private long empty;
    private long foo;

    @JsonProperty("bla")
    public FooBla getBla() { return bla; }
    @JsonProperty("bla")
    public void setBla(FooBla value) { this.bla = value; }

    @JsonProperty("_")
    public long getEmpty() { return empty; }
    @JsonProperty("_")
    public void setEmpty(long value) { this.empty = value; }

    @JsonProperty("__")
    public long getFoo() { return foo; }
    @JsonProperty("__")
    public void setFoo(long value) { this.foo = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Empty empty;
    private String foo;
    private String bar;

    @JsonProperty("empty")
    public Empty getEmpty() { return empty; }
    @JsonProperty("empty")
    public void setEmpty(Empty value) { this.empty = value; }

    @JsonProperty("foo")
    public String getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(String value) { this.foo = value; }

    @JsonProperty("bar")
    public String getBar() { return bar; }
    @JsonProperty("bar")
    public void setBar(String value) { this.bar = value; }
}

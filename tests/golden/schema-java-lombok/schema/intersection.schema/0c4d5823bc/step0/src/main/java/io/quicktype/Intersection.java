package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Intersection {
    private double foo;
    private String bar;

    @JsonProperty("foo")
    public double getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(double value) { this.foo = value; }

    @JsonProperty("bar")
    public String getBar() { return bar; }
    @JsonProperty("bar")
    public void setBar(String value) { this.bar = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Foo {
    private String bar;

    @JsonProperty("bar")
    public String getBar() { return bar; }
    @JsonProperty("bar")
    public void setBar(String value) { this.bar = value; }
}

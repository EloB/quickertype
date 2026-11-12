package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Option {
    private String foo;
    private String name;

    @JsonProperty("foo")
    public String getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(String value) { this.foo = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }
}

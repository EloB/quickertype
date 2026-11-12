package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private A a;

    @JsonProperty("a")
    public A getA() { return a; }
    @JsonProperty("a")
    public void setA(A value) { this.a = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private A a;
    private B b;
    private C c;

    @JsonProperty("a")
    public A getA() { return a; }
    @JsonProperty("a")
    public void setA(A value) { this.a = value; }

    @JsonProperty("b")
    public B getB() { return b; }
    @JsonProperty("b")
    public void setB(B value) { this.b = value; }

    @JsonProperty("c")
    public C getC() { return c; }
    @JsonProperty("c")
    public void setC(C value) { this.c = value; }
}

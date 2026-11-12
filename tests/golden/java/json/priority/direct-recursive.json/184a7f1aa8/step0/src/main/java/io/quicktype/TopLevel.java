package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private TopLevel also;
    private boolean bar;
    private long foo;
    private double moo;
    private String quux;

    @JsonProperty("also")
    public TopLevel getAlso() { return also; }
    @JsonProperty("also")
    public void setAlso(TopLevel value) { this.also = value; }

    @JsonProperty("bar")
    public boolean getBar() { return bar; }
    @JsonProperty("bar")
    public void setBar(boolean value) { this.bar = value; }

    @JsonProperty("foo")
    public long getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(long value) { this.foo = value; }

    @JsonProperty("moo")
    public double getMoo() { return moo; }
    @JsonProperty("moo")
    public void setMoo(double value) { this.moo = value; }

    @JsonProperty("quux")
    public String getQuux() { return quux; }
    @JsonProperty("quux")
    public void setQuux(String value) { this.quux = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Bar bar;

    @JsonProperty("bar")
    public Bar getBar() { return bar; }
    @JsonProperty("bar")
    public void setBar(Bar value) { this.bar = value; }
}

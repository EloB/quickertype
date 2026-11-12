package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;

public class TopLevel {
    private BarUnion bar;
    private String foo;

    @JsonProperty("bar")
    public BarUnion getBar() { return bar; }
    @JsonProperty("bar")
    public void setBar(BarUnion value) { this.bar = value; }

    @JsonProperty("foo")
    public String getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(String value) { this.foo = value; }
}

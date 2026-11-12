package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private Object disallowed;
    private List<Object> empty;
    private String foo;
    private Object impossible;

    @JsonProperty("disallowed")
    public Object getDisallowed() { return disallowed; }
    @JsonProperty("disallowed")
    public void setDisallowed(Object value) { this.disallowed = value; }

    @JsonProperty("empty")
    public List<Object> getEmpty() { return empty; }
    @JsonProperty("empty")
    public void setEmpty(List<Object> value) { this.empty = value; }

    @JsonProperty("foo")
    public String getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(String value) { this.foo = value; }

    @JsonProperty("impossible")
    public Object getImpossible() { return impossible; }
    @JsonProperty("impossible")
    public void setImpossible(Object value) { this.impossible = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Map;

public class TopLevel {
    private Object foo;
    private Map<String, Object> values;

    @JsonProperty("foo")
    public Object getFoo() { return foo; }
    @JsonProperty("foo")
    public void setFoo(Object value) { this.foo = value; }

    @JsonProperty("values")
    public Map<String, Object> getValues() { return values; }
    @JsonProperty("values")
    public void setValues(Map<String, Object> value) { this.values = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;
import java.util.Map;

public class XClass {
    private X x;

    @JsonProperty("x")
    public X getX() { return x; }
    @JsonProperty("x")
    public void setX(X value) { this.x = value; }
}

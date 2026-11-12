package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Bar {
    private X x;

    @JsonProperty("x")
    public X getX() { return x; }
    @JsonProperty("x")
    public void setX(X value) { this.x = value; }
}

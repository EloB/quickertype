package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class BoolInUnion {
    private boolean a;

    @JsonProperty("a")
    public boolean getA() { return a; }
    @JsonProperty("a")
    public void setA(boolean value) { this.a = value; }
}

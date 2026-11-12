package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class ObjectOrStringClass {
    private double prop;

    /**
     * This must not get lost
     */
    @JsonProperty("prop")
    public double getProp() { return prop; }
    @JsonProperty("prop")
    public void setProp(double value) { this.prop = value; }
}

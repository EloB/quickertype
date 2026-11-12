package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private double value;

    @JsonProperty("value")
    public double getValue() { return value; }
    @JsonProperty("value")
    public void setValue(double value) { this.value = value; }
}

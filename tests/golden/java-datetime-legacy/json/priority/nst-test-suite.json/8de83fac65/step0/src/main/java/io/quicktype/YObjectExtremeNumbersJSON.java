package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class YObjectExtremeNumbersJSON {
    private double max;
    private double min;

    @JsonProperty("max")
    public double getMax() { return max; }
    @JsonProperty("max")
    public void setMax(double value) { this.max = value; }

    @JsonProperty("min")
    public double getMin() { return min; }
    @JsonProperty("min")
    public void setMin(double value) { this.min = value; }
}

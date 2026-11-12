package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Limit {
    private Double maximum;
    private Double minimum;

    @JsonProperty("maximum")
    public Double getMaximum() { return maximum; }
    @JsonProperty("maximum")
    public void setMaximum(Double value) { this.maximum = value; }

    @JsonProperty("minimum")
    public Double getMinimum() { return minimum; }
    @JsonProperty("minimum")
    public void setMinimum(Double value) { this.minimum = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class VGScheme {
    private Double count;
    private List<Double> extent;
    private String scheme;
    private Double step;

    @JsonProperty("count")
    public Double getCount() { return count; }
    @JsonProperty("count")
    public void setCount(Double value) { this.count = value; }

    @JsonProperty("extent")
    public List<Double> getExtent() { return extent; }
    @JsonProperty("extent")
    public void setExtent(List<Double> value) { this.extent = value; }

    @JsonProperty("scheme")
    public String getScheme() { return scheme; }
    @JsonProperty("scheme")
    public void setScheme(String value) { this.scheme = value; }

    @JsonProperty("step")
    public Double getStep() { return step; }
    @JsonProperty("step")
    public void setStep(Double value) { this.step = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class VGBinding {
    private String element;
    private String input;
    private List<String> options;
    private Double max;
    private Double min;
    private Double step;

    @JsonProperty("element")
    public String getElement() { return element; }
    @JsonProperty("element")
    public void setElement(String value) { this.element = value; }

    @JsonProperty("input")
    public String getInput() { return input; }
    @JsonProperty("input")
    public void setInput(String value) { this.input = value; }

    @JsonProperty("options")
    public List<String> getOptions() { return options; }
    @JsonProperty("options")
    public void setOptions(List<String> value) { this.options = value; }

    @JsonProperty("max")
    public Double getMax() { return max; }
    @JsonProperty("max")
    public void setMax(Double value) { this.max = value; }

    @JsonProperty("min")
    public Double getMin() { return min; }
    @JsonProperty("min")
    public void setMin(Double value) { this.min = value; }

    @JsonProperty("step")
    public Double getStep() { return step; }
    @JsonProperty("step")
    public void setStep(Double value) { this.step = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String minMaxLength;
    private double percent;

    @JsonProperty("minMaxLength")
    public String getMinMaxLength() { return minMaxLength; }
    @JsonProperty("minMaxLength")
    public void setMinMaxLength(String value) { this.minMaxLength = value; }

    @JsonProperty("percent")
    public double getPercent() { return percent; }
    @JsonProperty("percent")
    public void setPercent(double value) { this.percent = value; }
}

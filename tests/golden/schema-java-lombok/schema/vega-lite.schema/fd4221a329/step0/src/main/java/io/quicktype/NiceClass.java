package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class NiceClass {
    private String interval;
    private double step;

    @JsonProperty("interval")
    public String getInterval() { return interval; }
    @JsonProperty("interval")
    public void setInterval(String value) { this.interval = value; }

    @JsonProperty("step")
    public double getStep() { return step; }
    @JsonProperty("step")
    public void setStep(double value) { this.step = value; }
}

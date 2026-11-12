package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private double free;
    private double intersection;
    private double max;
    private double min;
    private double minmax;
    private double minMaxIntersection;
    private double minMaxUnion;
    private double union;

    @JsonProperty("free")
    public double getFree() { return free; }
    @JsonProperty("free")
    public void setFree(double value) { this.free = value; }

    @JsonProperty("intersection")
    public double getIntersection() { return intersection; }
    @JsonProperty("intersection")
    public void setIntersection(double value) { this.intersection = value; }

    @JsonProperty("max")
    public double getMax() { return max; }
    @JsonProperty("max")
    public void setMax(double value) { this.max = value; }

    @JsonProperty("min")
    public double getMin() { return min; }
    @JsonProperty("min")
    public void setMin(double value) { this.min = value; }

    @JsonProperty("minmax")
    public double getMinmax() { return minmax; }
    @JsonProperty("minmax")
    public void setMinmax(double value) { this.minmax = value; }

    @JsonProperty("minMaxIntersection")
    public double getMinMaxIntersection() { return minMaxIntersection; }
    @JsonProperty("minMaxIntersection")
    public void setMinMaxIntersection(double value) { this.minMaxIntersection = value; }

    @JsonProperty("minMaxUnion")
    public double getMinMaxUnion() { return minMaxUnion; }
    @JsonProperty("minMaxUnion")
    public void setMinMaxUnion(double value) { this.minMaxUnion = value; }

    @JsonProperty("union")
    public double getUnion() { return union; }
    @JsonProperty("union")
    public void setUnion(double value) { this.union = value; }
}

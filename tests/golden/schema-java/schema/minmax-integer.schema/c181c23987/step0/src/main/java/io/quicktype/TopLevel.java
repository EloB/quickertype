package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private long free;
    private long intersection;
    private long max;
    private long min;
    private long minmax;
    private long minMaxIntersection;
    private long minMaxUnion;
    private long union;

    @JsonProperty("free")
    public long getFree() { return free; }
    @JsonProperty("free")
    public void setFree(long value) { this.free = value; }

    @JsonProperty("intersection")
    public long getIntersection() { return intersection; }
    @JsonProperty("intersection")
    public void setIntersection(long value) { this.intersection = value; }

    @JsonProperty("max")
    public long getMax() { return max; }
    @JsonProperty("max")
    public void setMax(long value) { this.max = value; }

    @JsonProperty("min")
    public long getMin() { return min; }
    @JsonProperty("min")
    public void setMin(long value) { this.min = value; }

    @JsonProperty("minmax")
    public long getMinmax() { return minmax; }
    @JsonProperty("minmax")
    public void setMinmax(long value) { this.minmax = value; }

    @JsonProperty("minMaxIntersection")
    public long getMinMaxIntersection() { return minMaxIntersection; }
    @JsonProperty("minMaxIntersection")
    public void setMinMaxIntersection(long value) { this.minMaxIntersection = value; }

    @JsonProperty("minMaxUnion")
    public long getMinMaxUnion() { return minMaxUnion; }
    @JsonProperty("minMaxUnion")
    public void setMinMaxUnion(long value) { this.minMaxUnion = value; }

    @JsonProperty("union")
    public long getUnion() { return union; }
    @JsonProperty("union")
    public void setUnion(long value) { this.union = value; }
}

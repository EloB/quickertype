package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Double intersection;

    @JsonProperty("intersection")
    public Double getIntersection() { return intersection; }
    @JsonProperty("intersection")
    public void setIntersection(Double value) { this.intersection = value; }
}

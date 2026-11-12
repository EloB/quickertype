package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Intersection intersection;

    @JsonProperty("intersection")
    public Intersection getIntersection() { return intersection; }
    @JsonProperty("intersection")
    public void setIntersection(Intersection value) { this.intersection = value; }
}

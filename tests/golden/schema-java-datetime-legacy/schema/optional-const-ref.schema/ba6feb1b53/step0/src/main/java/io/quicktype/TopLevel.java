package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Coordinate> coordinates;
    private Long count;
    private String label;
    private List<Coordinate> requiredCoordinates;
    private long requiredCount;
    private String requiredLabel;
    private Double weight;

    @JsonProperty("coordinates")
    public List<Coordinate> getCoordinates() { return coordinates; }
    @JsonProperty("coordinates")
    public void setCoordinates(List<Coordinate> value) { this.coordinates = value; }

    @JsonProperty("count")
    public Long getCount() { return count; }
    @JsonProperty("count")
    public void setCount(Long value) { this.count = value; }

    @JsonProperty("label")
    public String getLabel() { return label; }
    @JsonProperty("label")
    public void setLabel(String value) { this.label = value; }

    @JsonProperty("requiredCoordinates")
    public List<Coordinate> getRequiredCoordinates() { return requiredCoordinates; }
    @JsonProperty("requiredCoordinates")
    public void setRequiredCoordinates(List<Coordinate> value) { this.requiredCoordinates = value; }

    @JsonProperty("requiredCount")
    public long getRequiredCount() { return requiredCount; }
    @JsonProperty("requiredCount")
    public void setRequiredCount(long value) { this.requiredCount = value; }

    @JsonProperty("requiredLabel")
    public String getRequiredLabel() { return requiredLabel; }
    @JsonProperty("requiredLabel")
    public void setRequiredLabel(String value) { this.requiredLabel = value; }

    @JsonProperty("weight")
    public Double getWeight() { return weight; }
    @JsonProperty("weight")
    public void setWeight(Double value) { this.weight = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Geometry {
    private List<List<List<List<Double>>>> coordinates;
    private GeometryType type;

    @JsonProperty("coordinates")
    public List<List<List<List<Double>>>> getCoordinates() { return coordinates; }
    @JsonProperty("coordinates")
    public void setCoordinates(List<List<List<List<Double>>>> value) { this.coordinates = value; }

    @JsonProperty("type")
    public GeometryType getType() { return type; }
    @JsonProperty("type")
    public void setType(GeometryType value) { this.type = value; }
}

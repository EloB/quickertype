package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Geolocation {
    private List<Double> coordinates;
    private Type type;

    @JsonProperty("coordinates")
    public List<Double> getCoordinates() { return coordinates; }
    @JsonProperty("coordinates")
    public void setCoordinates(List<Double> value) { this.coordinates = value; }

    @JsonProperty("type")
    public Type getType() { return type; }
    @JsonProperty("type")
    public void setType(Type value) { this.type = value; }
}

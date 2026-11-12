package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Feature> features;
    private String name;
    private String type;

    @JsonProperty("features")
    public List<Feature> getFeatures() { return features; }
    @JsonProperty("features")
    public void setFeatures(List<Feature> value) { this.features = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }
}

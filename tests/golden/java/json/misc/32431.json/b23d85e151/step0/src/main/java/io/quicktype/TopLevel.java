package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Double> bbox;
    private List<Feature> features;
    private Metadata metadata;
    private String type;

    @JsonProperty("bbox")
    public List<Double> getBbox() { return bbox; }
    @JsonProperty("bbox")
    public void setBbox(List<Double> value) { this.bbox = value; }

    @JsonProperty("features")
    public List<Feature> getFeatures() { return features; }
    @JsonProperty("features")
    public void setFeatures(List<Feature> value) { this.features = value; }

    @JsonProperty("metadata")
    public Metadata getMetadata() { return metadata; }
    @JsonProperty("metadata")
    public void setMetadata(Metadata value) { this.metadata = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }
}

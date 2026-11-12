package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private CRS crs;
    private List<Feature> features;
    private long totalFeatures;
    private String type;

    @JsonProperty("crs")
    public CRS getCRS() { return crs; }
    @JsonProperty("crs")
    public void setCRS(CRS value) { this.crs = value; }

    @JsonProperty("features")
    public List<Feature> getFeatures() { return features; }
    @JsonProperty("features")
    public void setFeatures(List<Feature> value) { this.features = value; }

    @JsonProperty("totalFeatures")
    public long getTotalFeatures() { return totalFeatures; }
    @JsonProperty("totalFeatures")
    public void setTotalFeatures(long value) { this.totalFeatures = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }
}

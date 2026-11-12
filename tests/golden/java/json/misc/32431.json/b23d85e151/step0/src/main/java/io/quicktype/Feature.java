package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Feature {
    private Geometry geometry;
    private String id;
    private Properties properties;
    private FeatureType type;

    @JsonProperty("geometry")
    public Geometry getGeometry() { return geometry; }
    @JsonProperty("geometry")
    public void setGeometry(Geometry value) { this.geometry = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("properties")
    public Properties getProperties() { return properties; }
    @JsonProperty("properties")
    public void setProperties(Properties value) { this.properties = value; }

    @JsonProperty("type")
    public FeatureType getType() { return type; }
    @JsonProperty("type")
    public void setType(FeatureType value) { this.type = value; }
}

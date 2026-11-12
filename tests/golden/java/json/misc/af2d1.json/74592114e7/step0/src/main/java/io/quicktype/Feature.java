package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Feature {
    private Geometry geometry;
    private GeometryName geometryName;
    private String id;
    private FeatureProperties properties;
    private FeatureType type;

    @JsonProperty("geometry")
    public Geometry getGeometry() { return geometry; }
    @JsonProperty("geometry")
    public void setGeometry(Geometry value) { this.geometry = value; }

    @JsonProperty("geometry_name")
    public GeometryName getGeometryName() { return geometryName; }
    @JsonProperty("geometry_name")
    public void setGeometryName(GeometryName value) { this.geometryName = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("properties")
    public FeatureProperties getProperties() { return properties; }
    @JsonProperty("properties")
    public void setProperties(FeatureProperties value) { this.properties = value; }

    @JsonProperty("type")
    public FeatureType getType() { return type; }
    @JsonProperty("type")
    public void setType(FeatureType value) { this.type = value; }
}

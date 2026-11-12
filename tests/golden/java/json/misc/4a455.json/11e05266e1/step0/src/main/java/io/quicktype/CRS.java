package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class CRS {
    private CRSProperties properties;
    private String type;

    @JsonProperty("properties")
    public CRSProperties getProperties() { return properties; }
    @JsonProperty("properties")
    public void setProperties(CRSProperties value) { this.properties = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }
}

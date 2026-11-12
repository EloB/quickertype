package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Map;

public class Article {
    private Map<String, Property> properties;

    @JsonProperty("properties")
    public Map<String, Property> getProperties() { return properties; }
    @JsonProperty("properties")
    public void setProperties(Map<String, Property> value) { this.properties = value; }
}

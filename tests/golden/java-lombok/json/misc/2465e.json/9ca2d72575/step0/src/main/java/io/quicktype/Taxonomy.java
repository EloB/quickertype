package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Taxonomy {
    private Properties properties;

    @JsonProperty("properties")
    public Properties getProperties() { return properties; }
    @JsonProperty("properties")
    public void setProperties(Properties value) { this.properties = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Taxonomy {
    private TaxonomyProperties properties;

    @JsonProperty("properties")
    public TaxonomyProperties getProperties() { return properties; }
    @JsonProperty("properties")
    public void setProperties(TaxonomyProperties value) { this.properties = value; }
}

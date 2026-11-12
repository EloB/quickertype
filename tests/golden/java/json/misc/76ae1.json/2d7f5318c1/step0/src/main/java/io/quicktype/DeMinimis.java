package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DeMinimis {
    private DeMinimisProperties properties;

    @JsonProperty("properties")
    public DeMinimisProperties getProperties() { return properties; }
    @JsonProperty("properties")
    public void setProperties(DeMinimisProperties value) { this.properties = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class FAQ {
    private FAQProperties properties;

    @JsonProperty("properties")
    public FAQProperties getProperties() { return properties; }
    @JsonProperty("properties")
    public void setProperties(FAQProperties value) { this.properties = value; }
}

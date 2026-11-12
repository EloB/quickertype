package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Child {
    private ChildMetadata metadata;
    private String type;
    private String value;

    @JsonProperty("metadata")
    public ChildMetadata getMetadata() { return metadata; }
    @JsonProperty("metadata")
    public void setMetadata(ChildMetadata value) { this.metadata = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }

    @JsonProperty("value")
    public String getValue() { return value; }
    @JsonProperty("value")
    public void setValue(String value) { this.value = value; }
}

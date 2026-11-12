package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class FilterCondition {
    private List<Child> children;
    private FilterConditionMetadata metadata;
    private String type;
    private String value;

    @JsonProperty("children")
    public List<Child> getChildren() { return children; }
    @JsonProperty("children")
    public void setChildren(List<Child> value) { this.children = value; }

    @JsonProperty("metadata")
    public FilterConditionMetadata getMetadata() { return metadata; }
    @JsonProperty("metadata")
    public void setMetadata(FilterConditionMetadata value) { this.metadata = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }

    @JsonProperty("value")
    public String getValue() { return value; }
    @JsonProperty("value")
    public void setValue(String value) { this.value = value; }
}

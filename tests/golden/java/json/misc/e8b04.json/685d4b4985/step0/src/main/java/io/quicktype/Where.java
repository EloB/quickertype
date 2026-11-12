package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Where {
    private List<Child> children;
    private ChildColumnFieldName columnFieldName;
    private ChildMetadata metadata;
    private WhereOperator operator;
    private String value;

    @JsonProperty("children")
    public List<Child> getChildren() { return children; }
    @JsonProperty("children")
    public void setChildren(List<Child> value) { this.children = value; }

    @JsonProperty("columnFieldName")
    public ChildColumnFieldName getColumnFieldName() { return columnFieldName; }
    @JsonProperty("columnFieldName")
    public void setColumnFieldName(ChildColumnFieldName value) { this.columnFieldName = value; }

    @JsonProperty("metadata")
    public ChildMetadata getMetadata() { return metadata; }
    @JsonProperty("metadata")
    public void setMetadata(ChildMetadata value) { this.metadata = value; }

    @JsonProperty("operator")
    public WhereOperator getOperator() { return operator; }
    @JsonProperty("operator")
    public void setOperator(WhereOperator value) { this.operator = value; }

    @JsonProperty("value")
    public String getValue() { return value; }
    @JsonProperty("value")
    public void setValue(String value) { this.value = value; }
}

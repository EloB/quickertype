package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Child {
    private ChildColumnFieldName columnFieldName;
    private ChildMetadata metadata;
    private ChildOperator operator;
    private String value;

    @JsonProperty("columnFieldName")
    public ChildColumnFieldName getColumnFieldName() { return columnFieldName; }
    @JsonProperty("columnFieldName")
    public void setColumnFieldName(ChildColumnFieldName value) { this.columnFieldName = value; }

    @JsonProperty("metadata")
    public ChildMetadata getMetadata() { return metadata; }
    @JsonProperty("metadata")
    public void setMetadata(ChildMetadata value) { this.metadata = value; }

    @JsonProperty("operator")
    public ChildOperator getOperator() { return operator; }
    @JsonProperty("operator")
    public void setOperator(ChildOperator value) { this.operator = value; }

    @JsonProperty("value")
    public String getValue() { return value; }
    @JsonProperty("value")
    public void setValue(String value) { this.value = value; }
}

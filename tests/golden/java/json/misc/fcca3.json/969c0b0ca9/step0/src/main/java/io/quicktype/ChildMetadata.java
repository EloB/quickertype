package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class ChildMetadata {
    private List<List<String>> customValues;
    private String operator;
    private TableColumnID tableColumnID;

    @JsonProperty("customValues")
    public List<List<String>> getCustomValues() { return customValues; }
    @JsonProperty("customValues")
    public void setCustomValues(List<List<String>> value) { this.customValues = value; }

    @JsonProperty("operator")
    public String getOperator() { return operator; }
    @JsonProperty("operator")
    public void setOperator(String value) { this.operator = value; }

    @JsonProperty("tableColumnId")
    public TableColumnID getTableColumnID() { return tableColumnID; }
    @JsonProperty("tableColumnId")
    public void setTableColumnID(TableColumnID value) { this.tableColumnID = value; }
}

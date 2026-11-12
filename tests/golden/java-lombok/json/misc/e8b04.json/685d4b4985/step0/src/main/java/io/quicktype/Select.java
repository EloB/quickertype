package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Select {
    private String aggregate;
    private String columnFieldName;

    @JsonProperty("aggregate")
    public String getAggregate() { return aggregate; }
    @JsonProperty("aggregate")
    public void setAggregate(String value) { this.aggregate = value; }

    @JsonProperty("columnFieldName")
    public String getColumnFieldName() { return columnFieldName; }
    @JsonProperty("columnFieldName")
    public void setColumnFieldName(String value) { this.columnFieldName = value; }
}

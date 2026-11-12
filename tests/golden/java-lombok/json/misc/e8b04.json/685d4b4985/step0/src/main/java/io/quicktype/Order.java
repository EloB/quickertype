package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Order {
    private boolean ascending;
    private OrderColumnFieldName columnFieldName;

    @JsonProperty("ascending")
    public boolean getAscending() { return ascending; }
    @JsonProperty("ascending")
    public void setAscending(boolean value) { this.ascending = value; }

    @JsonProperty("columnFieldName")
    public OrderColumnFieldName getColumnFieldName() { return columnFieldName; }
    @JsonProperty("columnFieldName")
    public void setColumnFieldName(OrderColumnFieldName value) { this.columnFieldName = value; }
}

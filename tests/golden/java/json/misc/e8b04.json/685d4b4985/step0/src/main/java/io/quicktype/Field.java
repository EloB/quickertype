package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Field {
    private long tableColumnID;
    private FieldType type;

    @JsonProperty("tableColumnId")
    public long getTableColumnID() { return tableColumnID; }
    @JsonProperty("tableColumnId")
    public void setTableColumnID(long value) { this.tableColumnID = value; }

    @JsonProperty("type")
    public FieldType getType() { return type; }
    @JsonProperty("type")
    public void setType(FieldType value) { this.type = value; }
}

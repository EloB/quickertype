package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Expression {
    private long columnID;
    private String type;

    @JsonProperty("columnId")
    public long getColumnID() { return columnID; }
    @JsonProperty("columnId")
    public void setColumnID(long value) { this.columnID = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }
}

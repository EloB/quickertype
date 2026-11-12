package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class PurpleVisible {
    private Boolean fatrow;
    private Boolean table;

    @JsonProperty("fatrow")
    public Boolean getFatrow() { return fatrow; }
    @JsonProperty("fatrow")
    public void setFatrow(Boolean value) { this.fatrow = value; }

    @JsonProperty("table")
    public Boolean getTable() { return table; }
    @JsonProperty("table")
    public void setTable(Boolean value) { this.table = value; }
}

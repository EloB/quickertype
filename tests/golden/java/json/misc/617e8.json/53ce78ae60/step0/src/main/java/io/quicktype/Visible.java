package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Visible {
    private boolean table;

    @JsonProperty("table")
    public boolean getTable() { return table; }
    @JsonProperty("table")
    public void setTable(boolean value) { this.table = value; }
}

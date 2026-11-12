package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class FatRow {
    private List<Column> columns;

    @JsonProperty("columns")
    public List<Column> getColumns() { return columns; }
    @JsonProperty("columns")
    public void setColumns(List<Column> value) { this.columns = value; }
}

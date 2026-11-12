package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Column {
    private List<Row> rows;
    private Styles styles;

    @JsonProperty("rows")
    public List<Row> getRows() { return rows; }
    @JsonProperty("rows")
    public void setRows(List<Row> value) { this.rows = value; }

    @JsonProperty("styles")
    public Styles getStyles() { return styles; }
    @JsonProperty("styles")
    public void setStyles(Styles value) { this.styles = value; }
}

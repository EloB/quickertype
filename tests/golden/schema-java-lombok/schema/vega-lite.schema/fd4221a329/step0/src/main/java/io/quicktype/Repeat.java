package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

/**
 * An object that describes what fields should be repeated into views that are laid out as a
 * `row` or `column`.
 */
public class Repeat {
    private List<String> column;
    private List<String> row;

    /**
     * Horizontal repeated views.
     */
    @JsonProperty("column")
    public List<String> getColumn() { return column; }
    @JsonProperty("column")
    public void setColumn(List<String> value) { this.column = value; }

    /**
     * Vertical repeated views.
     */
    @JsonProperty("row")
    public List<String> getRow() { return row; }
    @JsonProperty("row")
    public void setRow(List<String> value) { this.row = value; }
}

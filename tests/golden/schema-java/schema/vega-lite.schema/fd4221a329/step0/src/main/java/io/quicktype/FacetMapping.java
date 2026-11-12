package io.quicktype;

import com.fasterxml.jackson.annotation.*;

/**
 * An object that describes mappings between `row` and `column` channels and their field
 * definitions.
 */
public class FacetMapping {
    private FacetFieldDef column;
    private FacetFieldDef row;

    /**
     * Horizontal facets for trellis plots.
     */
    @JsonProperty("column")
    public FacetFieldDef getColumn() { return column; }
    @JsonProperty("column")
    public void setColumn(FacetFieldDef value) { this.column = value; }

    /**
     * Vertical facets for trellis plots.
     */
    @JsonProperty("row")
    public FacetFieldDef getRow() { return row; }
    @JsonProperty("row")
    public void setRow(FacetFieldDef value) { this.row = value; }
}

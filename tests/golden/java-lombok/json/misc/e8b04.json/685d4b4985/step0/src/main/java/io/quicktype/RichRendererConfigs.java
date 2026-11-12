package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class RichRendererConfigs {
    private FatRow fatRow;

    @JsonProperty("fatRow")
    public FatRow getFatRow() { return fatRow; }
    @JsonProperty("fatRow")
    public void setFatRow(FatRow value) { this.fatRow = value; }
}

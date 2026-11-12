package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Format {
    private String align;
    private String noCommas;
    private String precisionStyle;
    private String view;

    @JsonProperty("align")
    public String getAlign() { return align; }
    @JsonProperty("align")
    public void setAlign(String value) { this.align = value; }

    @JsonProperty("noCommas")
    public String getNoCommas() { return noCommas; }
    @JsonProperty("noCommas")
    public void setNoCommas(String value) { this.noCommas = value; }

    @JsonProperty("precisionStyle")
    public String getPrecisionStyle() { return precisionStyle; }
    @JsonProperty("precisionStyle")
    public void setPrecisionStyle(String value) { this.precisionStyle = value; }

    @JsonProperty("view")
    public String getView() { return view; }
    @JsonProperty("view")
    public void setView(String value) { this.view = value; }
}

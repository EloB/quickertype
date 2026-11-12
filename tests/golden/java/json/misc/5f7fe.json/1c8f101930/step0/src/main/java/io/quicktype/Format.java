package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Format {
    private String align;
    private String view;

    @JsonProperty("align")
    public String getAlign() { return align; }
    @JsonProperty("align")
    public void setAlign(String value) { this.align = value; }

    @JsonProperty("view")
    public String getView() { return view; }
    @JsonProperty("view")
    public void setView(String value) { this.view = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Styles {
    private Width width;

    @JsonProperty("width")
    public Width getWidth() { return width; }
    @JsonProperty("width")
    public void setWidth(Width value) { this.width = value; }
}

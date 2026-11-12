package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Part {
    private String depth;
    private String length;
    private String width;

    @JsonProperty("depth")
    public String getDepth() { return depth; }
    @JsonProperty("depth")
    public void setDepth(String value) { this.depth = value; }

    @JsonProperty("length")
    public String getLength() { return length; }
    @JsonProperty("length")
    public void setLength(String value) { this.length = value; }

    @JsonProperty("width")
    public String getWidth() { return width; }
    @JsonProperty("width")
    public void setWidth(String value) { this.width = value; }
}

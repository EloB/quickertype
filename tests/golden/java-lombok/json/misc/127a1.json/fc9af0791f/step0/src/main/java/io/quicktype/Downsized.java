package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Downsized {
    private String height;
    private String size;
    private String url;
    private String width;

    @JsonProperty("height")
    public String getHeight() { return height; }
    @JsonProperty("height")
    public void setHeight(String value) { this.height = value; }

    @JsonProperty("size")
    public String getSize() { return size; }
    @JsonProperty("size")
    public void setSize(String value) { this.size = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }

    @JsonProperty("width")
    public String getWidth() { return width; }
    @JsonProperty("width")
    public void setWidth(String value) { this.width = value; }
}

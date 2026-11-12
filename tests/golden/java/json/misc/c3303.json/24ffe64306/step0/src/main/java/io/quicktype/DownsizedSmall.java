package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DownsizedSmall {
    private String height;
    private String mp4;
    private String mp4Size;
    private String width;

    @JsonProperty("height")
    public String getHeight() { return height; }
    @JsonProperty("height")
    public void setHeight(String value) { this.height = value; }

    @JsonProperty("mp4")
    public String getMp4() { return mp4; }
    @JsonProperty("mp4")
    public void setMp4(String value) { this.mp4 = value; }

    @JsonProperty("mp4_size")
    public String getMp4Size() { return mp4Size; }
    @JsonProperty("mp4_size")
    public void setMp4Size(String value) { this.mp4Size = value; }

    @JsonProperty("width")
    public String getWidth() { return width; }
    @JsonProperty("width")
    public void setWidth(String value) { this.width = value; }
}

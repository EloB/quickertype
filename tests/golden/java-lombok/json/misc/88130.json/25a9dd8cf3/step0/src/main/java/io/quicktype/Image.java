package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Image {
    private String height;
    private String link;
    private String title;
    private String url;
    private String width;

    @JsonProperty("height")
    public String getHeight() { return height; }
    @JsonProperty("height")
    public void setHeight(String value) { this.height = value; }

    @JsonProperty("link")
    public String getLink() { return link; }
    @JsonProperty("link")
    public void setLink(String value) { this.link = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }

    @JsonProperty("width")
    public String getWidth() { return width; }
    @JsonProperty("width")
    public void setWidth(String value) { this.width = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Text {
    private String mediaType;
    private String title;
    private String url;

    @JsonProperty("media_type")
    public String getMediaType() { return mediaType; }
    @JsonProperty("media_type")
    public void setMediaType(String value) { this.mediaType = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }
}

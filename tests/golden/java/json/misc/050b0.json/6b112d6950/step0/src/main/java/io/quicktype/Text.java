package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Text {
    private MediaType mediaType;
    private Title title;
    private String url;

    @JsonProperty("media_type")
    public MediaType getMediaType() { return mediaType; }
    @JsonProperty("media_type")
    public void setMediaType(MediaType value) { this.mediaType = value; }

    @JsonProperty("title")
    public Title getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(Title value) { this.title = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }
}

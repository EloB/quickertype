package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Oembed {
    private String authorName;
    private String authorURL;
    private long height;
    private String html;
    private String providerName;
    private String providerURL;
    private long thumbnailHeight;
    private String thumbnailURL;
    private long thumbnailWidth;
    private String title;
    private String type;
    private String version;
    private long width;

    @JsonProperty("author_name")
    public String getAuthorName() { return authorName; }
    @JsonProperty("author_name")
    public void setAuthorName(String value) { this.authorName = value; }

    @JsonProperty("author_url")
    public String getAuthorURL() { return authorURL; }
    @JsonProperty("author_url")
    public void setAuthorURL(String value) { this.authorURL = value; }

    @JsonProperty("height")
    public long getHeight() { return height; }
    @JsonProperty("height")
    public void setHeight(long value) { this.height = value; }

    @JsonProperty("html")
    public String getHTML() { return html; }
    @JsonProperty("html")
    public void setHTML(String value) { this.html = value; }

    @JsonProperty("provider_name")
    public String getProviderName() { return providerName; }
    @JsonProperty("provider_name")
    public void setProviderName(String value) { this.providerName = value; }

    @JsonProperty("provider_url")
    public String getProviderURL() { return providerURL; }
    @JsonProperty("provider_url")
    public void setProviderURL(String value) { this.providerURL = value; }

    @JsonProperty("thumbnail_height")
    public long getThumbnailHeight() { return thumbnailHeight; }
    @JsonProperty("thumbnail_height")
    public void setThumbnailHeight(long value) { this.thumbnailHeight = value; }

    @JsonProperty("thumbnail_url")
    public String getThumbnailURL() { return thumbnailURL; }
    @JsonProperty("thumbnail_url")
    public void setThumbnailURL(String value) { this.thumbnailURL = value; }

    @JsonProperty("thumbnail_width")
    public long getThumbnailWidth() { return thumbnailWidth; }
    @JsonProperty("thumbnail_width")
    public void setThumbnailWidth(long value) { this.thumbnailWidth = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }

    @JsonProperty("version")
    public String getVersion() { return version; }
    @JsonProperty("version")
    public void setVersion(String value) { this.version = value; }

    @JsonProperty("width")
    public long getWidth() { return width; }
    @JsonProperty("width")
    public void setWidth(long value) { this.width = value; }
}

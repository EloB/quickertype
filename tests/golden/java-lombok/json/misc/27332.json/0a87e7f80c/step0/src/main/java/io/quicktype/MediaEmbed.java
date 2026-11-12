package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class MediaEmbed {
    private String content;
    private Long height;
    private Boolean scrolling;
    private Long width;

    @JsonProperty("content")
    public String getContent() { return content; }
    @JsonProperty("content")
    public void setContent(String value) { this.content = value; }

    @JsonProperty("height")
    public Long getHeight() { return height; }
    @JsonProperty("height")
    public void setHeight(Long value) { this.height = value; }

    @JsonProperty("scrolling")
    public Boolean getScrolling() { return scrolling; }
    @JsonProperty("scrolling")
    public void setScrolling(Boolean value) { this.scrolling = value; }

    @JsonProperty("width")
    public Long getWidth() { return width; }
    @JsonProperty("width")
    public void setWidth(Long value) { this.width = value; }
}

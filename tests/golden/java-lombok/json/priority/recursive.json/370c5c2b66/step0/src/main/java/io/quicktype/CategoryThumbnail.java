package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class CategoryThumbnail {
    private String url;

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }
}

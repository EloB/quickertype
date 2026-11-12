package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class LinkLink {
    private String type;
    private String url;

    @JsonProperty("type")
    public String getType() { return type; }
    @JsonProperty("type")
    public void setType(String value) { this.type = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }
}

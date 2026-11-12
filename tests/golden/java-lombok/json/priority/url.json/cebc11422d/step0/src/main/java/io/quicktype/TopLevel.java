package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String fromURL;
    private String url;

    @JsonProperty("fromURL")
    public String getFromURL() { return fromURL; }
    @JsonProperty("fromURL")
    public void setFromURL(String value) { this.fromURL = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }
}

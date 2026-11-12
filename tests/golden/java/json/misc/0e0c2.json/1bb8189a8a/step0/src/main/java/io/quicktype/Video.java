package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Video {
    private String kind;
    private ResultLanguage language;
    private String source;
    private String url;

    @JsonProperty("kind")
    public String getKind() { return kind; }
    @JsonProperty("kind")
    public void setKind(String value) { this.kind = value; }

    @JsonProperty("language")
    public ResultLanguage getLanguage() { return language; }
    @JsonProperty("language")
    public void setLanguage(ResultLanguage value) { this.language = value; }

    @JsonProperty("source")
    public String getSource() { return source; }
    @JsonProperty("source")
    public void setSource(String value) { this.source = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }
}

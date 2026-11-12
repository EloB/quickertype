package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class YObjectStringUnicodeJSON {
    private String title;

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }
}

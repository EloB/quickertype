package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Comments {
    private String href;

    @JsonProperty("href")
    public String getHref() { return href; }
    @JsonProperty("href")
    public void setHref(String value) { this.href = value; }
}

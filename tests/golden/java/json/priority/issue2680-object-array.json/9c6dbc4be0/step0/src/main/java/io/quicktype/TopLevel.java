package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String key;

    @JsonProperty("key")
    public String getKey() { return key; }
    @JsonProperty("key")
    public void setKey(String value) { this.key = value; }
}

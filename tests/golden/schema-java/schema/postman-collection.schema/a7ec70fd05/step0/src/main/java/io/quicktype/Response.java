package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Response {
    private String body;

    @JsonProperty("body")
    public String getBody() { return body; }
    @JsonProperty("body")
    public void setBody(String value) { this.body = value; }
}

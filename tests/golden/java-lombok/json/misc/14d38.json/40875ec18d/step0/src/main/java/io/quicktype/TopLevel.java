package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Headers headers;

    @JsonProperty("headers")
    public Headers getHeaders() { return headers; }
    @JsonProperty("headers")
    public void setHeaders(Headers value) { this.headers = value; }
}

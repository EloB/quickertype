package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String userAgent;

    @JsonProperty("user-agent")
    public String getUserAgent() { return userAgent; }
    @JsonProperty("user-agent")
    public void setUserAgent(String value) { this.userAgent = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class UniformResourceLocatable {
    private String url;
    private String login;

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }

    @JsonProperty("login")
    public String getLogin() { return login; }
    @JsonProperty("login")
    public void setLogin(String value) { this.login = value; }
}

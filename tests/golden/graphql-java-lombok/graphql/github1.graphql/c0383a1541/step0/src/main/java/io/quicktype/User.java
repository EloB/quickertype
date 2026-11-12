package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class User {
    private String login;
    private String realName;

    @JsonProperty("login")
    public String getLogin() { return login; }
    @JsonProperty("login")
    public void setLogin(String value) { this.login = value; }

    @JsonProperty("realName")
    public String getRealName() { return realName; }
    @JsonProperty("realName")
    public void setRealName(String value) { this.realName = value; }
}

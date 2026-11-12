package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Actor {
    private String avatarURL;
    private String displayLogin;
    private String gravatarID;
    private long id;
    private String login;
    private String url;

    @JsonProperty("avatar_url")
    public String getAvatarURL() { return avatarURL; }
    @JsonProperty("avatar_url")
    public void setAvatarURL(String value) { this.avatarURL = value; }

    @JsonProperty("display_login")
    public String getDisplayLogin() { return displayLogin; }
    @JsonProperty("display_login")
    public void setDisplayLogin(String value) { this.displayLogin = value; }

    @JsonProperty("gravatar_id")
    public String getGravatarID() { return gravatarID; }
    @JsonProperty("gravatar_id")
    public void setGravatarID(String value) { this.gravatarID = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("login")
    public String getLogin() { return login; }
    @JsonProperty("login")
    public void setLogin(String value) { this.login = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }
}

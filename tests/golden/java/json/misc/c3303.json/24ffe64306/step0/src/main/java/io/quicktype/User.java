package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class User {
    private String avatarURL;
    private String bannerURL;
    private String displayName;
    private String profileURL;
    private Username username;

    @JsonProperty("avatar_url")
    public String getAvatarURL() { return avatarURL; }
    @JsonProperty("avatar_url")
    public void setAvatarURL(String value) { this.avatarURL = value; }

    @JsonProperty("banner_url")
    public String getBannerURL() { return bannerURL; }
    @JsonProperty("banner_url")
    public void setBannerURL(String value) { this.bannerURL = value; }

    @JsonProperty("display_name")
    public String getDisplayName() { return displayName; }
    @JsonProperty("display_name")
    public void setDisplayName(String value) { this.displayName = value; }

    @JsonProperty("profile_url")
    public String getProfileURL() { return profileURL; }
    @JsonProperty("profile_url")
    public void setProfileURL(String value) { this.profileURL = value; }

    @JsonProperty("username")
    public Username getUsername() { return username; }
    @JsonProperty("username")
    public void setUsername(Username value) { this.username = value; }
}

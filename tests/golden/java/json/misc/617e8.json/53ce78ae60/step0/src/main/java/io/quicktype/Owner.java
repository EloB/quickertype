package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Owner {
    private String displayName;
    private String id;
    private String profileImageURLLarge;
    private String profileImageURLMedium;
    private String profileImageURLSmall;
    private List<String> rights;
    private String roleName;
    private String screenName;

    @JsonProperty("displayName")
    public String getDisplayName() { return displayName; }
    @JsonProperty("displayName")
    public void setDisplayName(String value) { this.displayName = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("profileImageUrlLarge")
    public String getProfileImageURLLarge() { return profileImageURLLarge; }
    @JsonProperty("profileImageUrlLarge")
    public void setProfileImageURLLarge(String value) { this.profileImageURLLarge = value; }

    @JsonProperty("profileImageUrlMedium")
    public String getProfileImageURLMedium() { return profileImageURLMedium; }
    @JsonProperty("profileImageUrlMedium")
    public void setProfileImageURLMedium(String value) { this.profileImageURLMedium = value; }

    @JsonProperty("profileImageUrlSmall")
    public String getProfileImageURLSmall() { return profileImageURLSmall; }
    @JsonProperty("profileImageUrlSmall")
    public void setProfileImageURLSmall(String value) { this.profileImageURLSmall = value; }

    @JsonProperty("rights")
    public List<String> getRights() { return rights; }
    @JsonProperty("rights")
    public void setRights(List<String> value) { this.rights = value; }

    @JsonProperty("roleName")
    public String getRoleName() { return roleName; }
    @JsonProperty("roleName")
    public void setRoleName(String value) { this.roleName = value; }

    @JsonProperty("screenName")
    public String getScreenName() { return screenName; }
    @JsonProperty("screenName")
    public void setScreenName(String value) { this.screenName = value; }
}

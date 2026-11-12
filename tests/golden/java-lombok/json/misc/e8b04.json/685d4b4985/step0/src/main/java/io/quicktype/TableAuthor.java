package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TableAuthor {
    private String displayName;
    private String id;
    private List<String> rights;
    private RoleName roleName;
    private String screenName;

    @JsonProperty("displayName")
    public String getDisplayName() { return displayName; }
    @JsonProperty("displayName")
    public void setDisplayName(String value) { this.displayName = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("rights")
    public List<String> getRights() { return rights; }
    @JsonProperty("rights")
    public void setRights(List<String> value) { this.rights = value; }

    @JsonProperty("roleName")
    public RoleName getRoleName() { return roleName; }
    @JsonProperty("roleName")
    public void setRoleName(RoleName value) { this.roleName = value; }

    @JsonProperty("screenName")
    public String getScreenName() { return screenName; }
    @JsonProperty("screenName")
    public void setScreenName(String value) { this.screenName = value; }
}

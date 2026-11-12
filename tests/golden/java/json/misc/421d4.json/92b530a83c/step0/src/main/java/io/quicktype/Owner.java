package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Owner {
    private String displayName;
    private String id;
    private String screenName;

    @JsonProperty("displayName")
    public String getDisplayName() { return displayName; }
    @JsonProperty("displayName")
    public void setDisplayName(String value) { this.displayName = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("screenName")
    public String getScreenName() { return screenName; }
    @JsonProperty("screenName")
    public void setScreenName(String value) { this.screenName = value; }
}

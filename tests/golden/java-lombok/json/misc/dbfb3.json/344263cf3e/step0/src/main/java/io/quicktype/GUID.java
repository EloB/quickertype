package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class GUID {
    private String isPermaLink;

    @JsonProperty("isPermaLink")
    public String getIsPermaLink() { return isPermaLink; }
    @JsonProperty("isPermaLink")
    public void setIsPermaLink(String value) { this.isPermaLink = value; }
}

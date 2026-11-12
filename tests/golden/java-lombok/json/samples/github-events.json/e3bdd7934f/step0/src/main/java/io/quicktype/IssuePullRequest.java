package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class IssuePullRequest {
    private String diffURL;
    private String htmlURL;
    private String patchURL;
    private String url;

    @JsonProperty("diff_url")
    public String getDiffURL() { return diffURL; }
    @JsonProperty("diff_url")
    public void setDiffURL(String value) { this.diffURL = value; }

    @JsonProperty("html_url")
    public String getHTMLURL() { return htmlURL; }
    @JsonProperty("html_url")
    public void setHTMLURL(String value) { this.htmlURL = value; }

    @JsonProperty("patch_url")
    public String getPatchURL() { return patchURL; }
    @JsonProperty("patch_url")
    public void setPatchURL(String value) { this.patchURL = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }
}

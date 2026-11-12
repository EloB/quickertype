package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class IssueOrPullRequest {
    private String title;
    private IssueState state;
    private Boolean merged;

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }

    @JsonProperty("state")
    public IssueState getState() { return state; }
    @JsonProperty("state")
    public void setState(IssueState value) { this.state = value; }

    @JsonProperty("merged")
    public Boolean getMerged() { return merged; }
    @JsonProperty("merged")
    public void setMerged(Boolean value) { this.merged = value; }
}

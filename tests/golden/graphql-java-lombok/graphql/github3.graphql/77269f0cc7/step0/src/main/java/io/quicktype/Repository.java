package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Repository {
    private PullRequestConnection pullRequests;

    @JsonProperty("pullRequests")
    public PullRequestConnection getPullRequests() { return pullRequests; }
    @JsonProperty("pullRequests")
    public void setPullRequests(PullRequestConnection value) { this.pullRequests = value; }
}

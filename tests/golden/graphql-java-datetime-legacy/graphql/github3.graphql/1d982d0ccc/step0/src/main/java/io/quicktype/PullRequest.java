package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class PullRequest {
    private PullRequestState state;

    @JsonProperty("state")
    public PullRequestState getState() { return state; }
    @JsonProperty("state")
    public void setState(PullRequestState value) { this.state = value; }
}

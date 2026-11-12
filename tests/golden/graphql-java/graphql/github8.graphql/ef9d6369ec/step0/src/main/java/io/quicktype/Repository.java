package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Repository {
    private String nameWithOwner;
    private IssueOrPullRequest n303;
    private IssueOrPullRequest n307;

    @JsonProperty("nameWithOwner")
    public String getNameWithOwner() { return nameWithOwner; }
    @JsonProperty("nameWithOwner")
    public void setNameWithOwner(String value) { this.nameWithOwner = value; }

    @JsonProperty("n303")
    public IssueOrPullRequest getN303() { return n303; }
    @JsonProperty("n303")
    public void setN303(IssueOrPullRequest value) { this.n303 = value; }

    @JsonProperty("n307")
    public IssueOrPullRequest getN307() { return n307; }
    @JsonProperty("n307")
    public void setN307(IssueOrPullRequest value) { this.n307 = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Base {
    private String label;
    private String ref;
    private BaseRepo repo;
    private String sha;
    private MergedBy user;

    @JsonProperty("label")
    public String getLabel() { return label; }
    @JsonProperty("label")
    public void setLabel(String value) { this.label = value; }

    @JsonProperty("ref")
    public String getRef() { return ref; }
    @JsonProperty("ref")
    public void setRef(String value) { this.ref = value; }

    @JsonProperty("repo")
    public BaseRepo getRepo() { return repo; }
    @JsonProperty("repo")
    public void setRepo(BaseRepo value) { this.repo = value; }

    @JsonProperty("sha")
    public String getSHA() { return sha; }
    @JsonProperty("sha")
    public void setSHA(String value) { this.sha = value; }

    @JsonProperty("user")
    public MergedBy getUser() { return user; }
    @JsonProperty("user")
    public void setUser(MergedBy value) { this.user = value; }
}

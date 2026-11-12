package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Repository {
    private String name;
    private Connection stargazers;
    private Connection forks;
    private Connection watchers;
    private Connection issues;

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("stargazers")
    public Connection getStargazers() { return stargazers; }
    @JsonProperty("stargazers")
    public void setStargazers(Connection value) { this.stargazers = value; }

    @JsonProperty("forks")
    public Connection getForks() { return forks; }
    @JsonProperty("forks")
    public void setForks(Connection value) { this.forks = value; }

    @JsonProperty("watchers")
    public Connection getWatchers() { return watchers; }
    @JsonProperty("watchers")
    public void setWatchers(Connection value) { this.watchers = value; }

    @JsonProperty("issues")
    public Connection getIssues() { return issues; }
    @JsonProperty("issues")
    public void setIssues(Connection value) { this.issues = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class User {
    private String login;
    private Connection starredRepositories;
    private RepositoryConnection repositories;

    @JsonProperty("login")
    public String getLogin() { return login; }
    @JsonProperty("login")
    public void setLogin(String value) { this.login = value; }

    @JsonProperty("starredRepositories")
    public Connection getStarredRepositories() { return starredRepositories; }
    @JsonProperty("starredRepositories")
    public void setStarredRepositories(Connection value) { this.starredRepositories = value; }

    @JsonProperty("repositories")
    public RepositoryConnection getRepositories() { return repositories; }
    @JsonProperty("repositories")
    public void setRepositories(RepositoryConnection value) { this.repositories = value; }
}

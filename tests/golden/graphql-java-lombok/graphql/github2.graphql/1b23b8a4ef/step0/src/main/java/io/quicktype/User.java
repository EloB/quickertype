package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class User {
    private String login;
    private RepositoryConnection repositories;

    @JsonProperty("login")
    public String getLogin() { return login; }
    @JsonProperty("login")
    public void setLogin(String value) { this.login = value; }

    @JsonProperty("repositories")
    public RepositoryConnection getRepositories() { return repositories; }
    @JsonProperty("repositories")
    public void setRepositories(RepositoryConnection value) { this.repositories = value; }
}

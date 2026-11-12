package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class User {
    private String login;
    private Repository repository;

    @JsonProperty("login")
    public String getLogin() { return login; }
    @JsonProperty("login")
    public void setLogin(String value) { this.login = value; }

    @JsonProperty("repository")
    public Repository getRepository() { return repository; }
    @JsonProperty("repository")
    public void setRepository(Repository value) { this.repository = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class User {
    private String login;
    private String name;
    private Repository repository;

    @JsonProperty("login")
    public String getLogin() { return login; }
    @JsonProperty("login")
    public void setLogin(String value) { this.login = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("repository")
    public Repository getRepository() { return repository; }
    @JsonProperty("repository")
    public void setRepository(Repository value) { this.repository = value; }
}

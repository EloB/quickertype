package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Data {
    private Repository repository;

    @JsonProperty("repository")
    public Repository getRepository() { return repository; }
    @JsonProperty("repository")
    public void setRepository(Repository value) { this.repository = value; }
}

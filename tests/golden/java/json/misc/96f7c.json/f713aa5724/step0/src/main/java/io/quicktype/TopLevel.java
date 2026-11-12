package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<String> git;
    private String githubServicesSHA;
    private List<String> hooks;
    private List<String> importer;
    private List<String> pages;
    private boolean verifiablePasswordAuthentication;

    @JsonProperty("git")
    public List<String> getGit() { return git; }
    @JsonProperty("git")
    public void setGit(List<String> value) { this.git = value; }

    @JsonProperty("github_services_sha")
    public String getGithubServicesSHA() { return githubServicesSHA; }
    @JsonProperty("github_services_sha")
    public void setGithubServicesSHA(String value) { this.githubServicesSHA = value; }

    @JsonProperty("hooks")
    public List<String> getHooks() { return hooks; }
    @JsonProperty("hooks")
    public void setHooks(List<String> value) { this.hooks = value; }

    @JsonProperty("importer")
    public List<String> getImporter() { return importer; }
    @JsonProperty("importer")
    public void setImporter(List<String> value) { this.importer = value; }

    @JsonProperty("pages")
    public List<String> getPages() { return pages; }
    @JsonProperty("pages")
    public void setPages(List<String> value) { this.pages = value; }

    @JsonProperty("verifiable_password_authentication")
    public boolean getVerifiablePasswordAuthentication() { return verifiablePasswordAuthentication; }
    @JsonProperty("verifiable_password_authentication")
    public void setVerifiablePasswordAuthentication(boolean value) { this.verifiablePasswordAuthentication = value; }
}

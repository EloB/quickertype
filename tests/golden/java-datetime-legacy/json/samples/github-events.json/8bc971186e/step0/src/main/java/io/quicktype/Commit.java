package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Commit {
    private Author author;
    private boolean distinct;
    private String message;
    private String sha;
    private String url;

    @JsonProperty("author")
    public Author getAuthor() { return author; }
    @JsonProperty("author")
    public void setAuthor(Author value) { this.author = value; }

    @JsonProperty("distinct")
    public boolean getDistinct() { return distinct; }
    @JsonProperty("distinct")
    public void setDistinct(boolean value) { this.distinct = value; }

    @JsonProperty("message")
    public String getMessage() { return message; }
    @JsonProperty("message")
    public void setMessage(String value) { this.message = value; }

    @JsonProperty("sha")
    public String getSHA() { return sha; }
    @JsonProperty("sha")
    public void setSHA(String value) { this.sha = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }
}

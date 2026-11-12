package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;
import java.util.Map;

public class TopLevel {
    private long comments;
    private String commentsURL;
    private String commitsURL;
    private OffsetDateTime createdAt;
    private String description;
    private Map<String, File> files;
    private String forksURL;
    private String gitPullURL;
    private String gitPushURL;
    private String htmlURL;
    private String id;
    private boolean topLevelPublic;
    private boolean truncated;
    private OffsetDateTime updatedAt;
    private String url;
    private Object user;

    @JsonProperty("comments")
    public long getComments() { return comments; }
    @JsonProperty("comments")
    public void setComments(long value) { this.comments = value; }

    @JsonProperty("comments_url")
    public String getCommentsURL() { return commentsURL; }
    @JsonProperty("comments_url")
    public void setCommentsURL(String value) { this.commentsURL = value; }

    @JsonProperty("commits_url")
    public String getCommitsURL() { return commitsURL; }
    @JsonProperty("commits_url")
    public void setCommitsURL(String value) { this.commitsURL = value; }

    @JsonProperty("created_at")
    public OffsetDateTime getCreatedAt() { return createdAt; }
    @JsonProperty("created_at")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setCreatedAt(OffsetDateTime value) { this.createdAt = value; }

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("files")
    public Map<String, File> getFiles() { return files; }
    @JsonProperty("files")
    public void setFiles(Map<String, File> value) { this.files = value; }

    @JsonProperty("forks_url")
    public String getForksURL() { return forksURL; }
    @JsonProperty("forks_url")
    public void setForksURL(String value) { this.forksURL = value; }

    @JsonProperty("git_pull_url")
    public String getGitPullURL() { return gitPullURL; }
    @JsonProperty("git_pull_url")
    public void setGitPullURL(String value) { this.gitPullURL = value; }

    @JsonProperty("git_push_url")
    public String getGitPushURL() { return gitPushURL; }
    @JsonProperty("git_push_url")
    public void setGitPushURL(String value) { this.gitPushURL = value; }

    @JsonProperty("html_url")
    public String getHTMLURL() { return htmlURL; }
    @JsonProperty("html_url")
    public void setHTMLURL(String value) { this.htmlURL = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("public")
    public boolean getTopLevelPublic() { return topLevelPublic; }
    @JsonProperty("public")
    public void setTopLevelPublic(boolean value) { this.topLevelPublic = value; }

    @JsonProperty("truncated")
    public boolean getTruncated() { return truncated; }
    @JsonProperty("truncated")
    public void setTruncated(boolean value) { this.truncated = value; }

    @JsonProperty("updated_at")
    public OffsetDateTime getUpdatedAt() { return updatedAt; }
    @JsonProperty("updated_at")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setUpdatedAt(OffsetDateTime value) { this.updatedAt = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }

    @JsonProperty("user")
    public Object getUser() { return user; }
    @JsonProperty("user")
    public void setUser(Object value) { this.user = value; }
}

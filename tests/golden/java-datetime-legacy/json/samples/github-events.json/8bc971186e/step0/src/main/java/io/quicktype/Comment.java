package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Date;

public class Comment {
    private String body;
    private Date createdAt;
    private String htmlURL;
    private long id;
    private String issueURL;
    private Date updatedAt;
    private String url;
    private User user;

    @JsonProperty("body")
    public String getBody() { return body; }
    @JsonProperty("body")
    public void setBody(String value) { this.body = value; }

    @JsonProperty("created_at")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public Date getCreatedAt() { return createdAt; }
    @JsonProperty("created_at")
    @JsonSetter(nulls = Nulls.FAIL)
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public void setCreatedAt(Date value) { this.createdAt = value; }

    @JsonProperty("html_url")
    public String getHTMLURL() { return htmlURL; }
    @JsonProperty("html_url")
    public void setHTMLURL(String value) { this.htmlURL = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("issue_url")
    public String getIssueURL() { return issueURL; }
    @JsonProperty("issue_url")
    public void setIssueURL(String value) { this.issueURL = value; }

    @JsonProperty("updated_at")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public Date getUpdatedAt() { return updatedAt; }
    @JsonProperty("updated_at")
    @JsonSetter(nulls = Nulls.FAIL)
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public void setUpdatedAt(Date value) { this.updatedAt = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }

    @JsonProperty("user")
    public User getUser() { return user; }
    @JsonProperty("user")
    public void setUser(User value) { this.user = value; }
}

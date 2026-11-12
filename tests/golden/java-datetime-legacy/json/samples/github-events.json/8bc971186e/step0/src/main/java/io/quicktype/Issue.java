package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Date;
import java.util.List;

public class Issue {
    private Object assignee;
    private List<Object> assignees;
    private String body;
    private Date closedAt;
    private long comments;
    private String commentsURL;
    private Date createdAt;
    private String eventsURL;
    private String htmlURL;
    private long id;
    private List<Label> labels;
    private String labelsURL;
    private boolean locked;
    private Milestone milestone;
    private long number;
    private IssuePullRequest pullRequest;
    private String repositoryURL;
    private String state;
    private String title;
    private Date updatedAt;
    private String url;
    private User user;

    @JsonProperty("assignee")
    public Object getAssignee() { return assignee; }
    @JsonProperty("assignee")
    public void setAssignee(Object value) { this.assignee = value; }

    @JsonProperty("assignees")
    public List<Object> getAssignees() { return assignees; }
    @JsonProperty("assignees")
    public void setAssignees(List<Object> value) { this.assignees = value; }

    @JsonProperty("body")
    public String getBody() { return body; }
    @JsonProperty("body")
    public void setBody(String value) { this.body = value; }

    @JsonProperty("closed_at")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public Date getClosedAt() { return closedAt; }
    @JsonProperty("closed_at")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public void setClosedAt(Date value) { this.closedAt = value; }

    @JsonProperty("comments")
    public long getComments() { return comments; }
    @JsonProperty("comments")
    public void setComments(long value) { this.comments = value; }

    @JsonProperty("comments_url")
    public String getCommentsURL() { return commentsURL; }
    @JsonProperty("comments_url")
    public void setCommentsURL(String value) { this.commentsURL = value; }

    @JsonProperty("created_at")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public Date getCreatedAt() { return createdAt; }
    @JsonProperty("created_at")
    @JsonSetter(nulls = Nulls.FAIL)
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public void setCreatedAt(Date value) { this.createdAt = value; }

    @JsonProperty("events_url")
    public String getEventsURL() { return eventsURL; }
    @JsonProperty("events_url")
    public void setEventsURL(String value) { this.eventsURL = value; }

    @JsonProperty("html_url")
    public String getHTMLURL() { return htmlURL; }
    @JsonProperty("html_url")
    public void setHTMLURL(String value) { this.htmlURL = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("labels")
    public List<Label> getLabels() { return labels; }
    @JsonProperty("labels")
    public void setLabels(List<Label> value) { this.labels = value; }

    @JsonProperty("labels_url")
    public String getLabelsURL() { return labelsURL; }
    @JsonProperty("labels_url")
    public void setLabelsURL(String value) { this.labelsURL = value; }

    @JsonProperty("locked")
    public boolean getLocked() { return locked; }
    @JsonProperty("locked")
    public void setLocked(boolean value) { this.locked = value; }

    @JsonProperty("milestone")
    public Milestone getMilestone() { return milestone; }
    @JsonProperty("milestone")
    public void setMilestone(Milestone value) { this.milestone = value; }

    @JsonProperty("number")
    public long getNumber() { return number; }
    @JsonProperty("number")
    public void setNumber(long value) { this.number = value; }

    @JsonProperty("pull_request")
    public IssuePullRequest getPullRequest() { return pullRequest; }
    @JsonProperty("pull_request")
    public void setPullRequest(IssuePullRequest value) { this.pullRequest = value; }

    @JsonProperty("repository_url")
    public String getRepositoryURL() { return repositoryURL; }
    @JsonProperty("repository_url")
    public void setRepositoryURL(String value) { this.repositoryURL = value; }

    @JsonProperty("state")
    public String getState() { return state; }
    @JsonProperty("state")
    public void setState(String value) { this.state = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }

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

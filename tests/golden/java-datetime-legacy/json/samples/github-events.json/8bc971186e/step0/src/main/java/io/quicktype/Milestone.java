package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.Date;

public class Milestone {
    private Object closedAt;
    private long closedIssues;
    private Date createdAt;
    private User creator;
    private String description;
    private Date dueOn;
    private String htmlURL;
    private long id;
    private String labelsURL;
    private long number;
    private long openIssues;
    private String state;
    private String title;
    private Date updatedAt;
    private String url;

    @JsonProperty("closed_at")
    public Object getClosedAt() { return closedAt; }
    @JsonProperty("closed_at")
    public void setClosedAt(Object value) { this.closedAt = value; }

    @JsonProperty("closed_issues")
    public long getClosedIssues() { return closedIssues; }
    @JsonProperty("closed_issues")
    public void setClosedIssues(long value) { this.closedIssues = value; }

    @JsonProperty("created_at")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public Date getCreatedAt() { return createdAt; }
    @JsonProperty("created_at")
    @JsonSetter(nulls = Nulls.FAIL)
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public void setCreatedAt(Date value) { this.createdAt = value; }

    @JsonProperty("creator")
    public User getCreator() { return creator; }
    @JsonProperty("creator")
    public void setCreator(User value) { this.creator = value; }

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("due_on")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public Date getDueOn() { return dueOn; }
    @JsonProperty("due_on")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX", timezone = "UTC")
    public void setDueOn(Date value) { this.dueOn = value; }

    @JsonProperty("html_url")
    public String getHTMLURL() { return htmlURL; }
    @JsonProperty("html_url")
    public void setHTMLURL(String value) { this.htmlURL = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("labels_url")
    public String getLabelsURL() { return labelsURL; }
    @JsonProperty("labels_url")
    public void setLabelsURL(String value) { this.labelsURL = value; }

    @JsonProperty("number")
    public long getNumber() { return number; }
    @JsonProperty("number")
    public void setNumber(long value) { this.number = value; }

    @JsonProperty("open_issues")
    public long getOpenIssues() { return openIssues; }
    @JsonProperty("open_issues")
    public void setOpenIssues(long value) { this.openIssues = value; }

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
}

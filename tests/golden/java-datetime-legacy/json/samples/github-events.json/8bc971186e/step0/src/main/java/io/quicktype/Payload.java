package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Payload {
    private String action;
    private String before;
    private Comment comment;
    private List<Commit> commits;
    private String description;
    private Long distinctSize;
    private String head;
    private Issue issue;
    private String masterBranch;
    private Long number;
    private PayloadPullRequest pullRequest;
    private Long pushID;
    private String pusherType;
    private String ref;
    private String refType;
    private Long size;

    @JsonProperty("action")
    public String getAction() { return action; }
    @JsonProperty("action")
    public void setAction(String value) { this.action = value; }

    @JsonProperty("before")
    public String getBefore() { return before; }
    @JsonProperty("before")
    public void setBefore(String value) { this.before = value; }

    @JsonProperty("comment")
    public Comment getComment() { return comment; }
    @JsonProperty("comment")
    public void setComment(Comment value) { this.comment = value; }

    @JsonProperty("commits")
    public List<Commit> getCommits() { return commits; }
    @JsonProperty("commits")
    public void setCommits(List<Commit> value) { this.commits = value; }

    @JsonProperty("description")
    public String getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(String value) { this.description = value; }

    @JsonProperty("distinct_size")
    public Long getDistinctSize() { return distinctSize; }
    @JsonProperty("distinct_size")
    public void setDistinctSize(Long value) { this.distinctSize = value; }

    @JsonProperty("head")
    public String getHead() { return head; }
    @JsonProperty("head")
    public void setHead(String value) { this.head = value; }

    @JsonProperty("issue")
    public Issue getIssue() { return issue; }
    @JsonProperty("issue")
    public void setIssue(Issue value) { this.issue = value; }

    @JsonProperty("master_branch")
    public String getMasterBranch() { return masterBranch; }
    @JsonProperty("master_branch")
    public void setMasterBranch(String value) { this.masterBranch = value; }

    @JsonProperty("number")
    public Long getNumber() { return number; }
    @JsonProperty("number")
    public void setNumber(Long value) { this.number = value; }

    @JsonProperty("pull_request")
    public PayloadPullRequest getPullRequest() { return pullRequest; }
    @JsonProperty("pull_request")
    public void setPullRequest(PayloadPullRequest value) { this.pullRequest = value; }

    @JsonProperty("push_id")
    public Long getPushID() { return pushID; }
    @JsonProperty("push_id")
    public void setPushID(Long value) { this.pushID = value; }

    @JsonProperty("pusher_type")
    public String getPusherType() { return pusherType; }
    @JsonProperty("pusher_type")
    public void setPusherType(String value) { this.pusherType = value; }

    @JsonProperty("ref")
    public String getRef() { return ref; }
    @JsonProperty("ref")
    public void setRef(String value) { this.ref = value; }

    @JsonProperty("ref_type")
    public String getRefType() { return refType; }
    @JsonProperty("ref_type")
    public void setRefType(String value) { this.refType = value; }

    @JsonProperty("size")
    public Long getSize() { return size; }
    @JsonProperty("size")
    public void setSize(Long value) { this.size = value; }
}

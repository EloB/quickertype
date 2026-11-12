package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;
import java.util.List;

public class PayloadPullRequest {
    private long additions;
    private Object assignee;
    private List<Object> assignees;
    private Base base;
    private String body;
    private long changedFiles;
    private OffsetDateTime closedAt;
    private long comments;
    private String commentsURL;
    private long commits;
    private String commitsURL;
    private OffsetDateTime createdAt;
    private long deletions;
    private String diffURL;
    private Base head;
    private String htmlURL;
    private long id;
    private String issueURL;
    private Links links;
    private boolean locked;
    private boolean maintainerCanModify;
    private String mergeCommitSHA;
    private Object mergeable;
    private String mergeableState;
    private boolean merged;
    private OffsetDateTime mergedAt;
    private User mergedBy;
    private Object milestone;
    private long number;
    private String patchURL;
    private Object rebaseable;
    private List<Object> requestedReviewers;
    private String reviewCommentURL;
    private long reviewComments;
    private String reviewCommentsURL;
    private String state;
    private String statusesURL;
    private String title;
    private OffsetDateTime updatedAt;
    private String url;
    private User user;

    @JsonProperty("additions")
    public long getAdditions() { return additions; }
    @JsonProperty("additions")
    public void setAdditions(long value) { this.additions = value; }

    @JsonProperty("assignee")
    public Object getAssignee() { return assignee; }
    @JsonProperty("assignee")
    public void setAssignee(Object value) { this.assignee = value; }

    @JsonProperty("assignees")
    public List<Object> getAssignees() { return assignees; }
    @JsonProperty("assignees")
    public void setAssignees(List<Object> value) { this.assignees = value; }

    @JsonProperty("base")
    public Base getBase() { return base; }
    @JsonProperty("base")
    public void setBase(Base value) { this.base = value; }

    @JsonProperty("body")
    public String getBody() { return body; }
    @JsonProperty("body")
    public void setBody(String value) { this.body = value; }

    @JsonProperty("changed_files")
    public long getChangedFiles() { return changedFiles; }
    @JsonProperty("changed_files")
    public void setChangedFiles(long value) { this.changedFiles = value; }

    @JsonProperty("closed_at")
    public OffsetDateTime getClosedAt() { return closedAt; }
    @JsonProperty("closed_at")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setClosedAt(OffsetDateTime value) { this.closedAt = value; }

    @JsonProperty("comments")
    public long getComments() { return comments; }
    @JsonProperty("comments")
    public void setComments(long value) { this.comments = value; }

    @JsonProperty("comments_url")
    public String getCommentsURL() { return commentsURL; }
    @JsonProperty("comments_url")
    public void setCommentsURL(String value) { this.commentsURL = value; }

    @JsonProperty("commits")
    public long getCommits() { return commits; }
    @JsonProperty("commits")
    public void setCommits(long value) { this.commits = value; }

    @JsonProperty("commits_url")
    public String getCommitsURL() { return commitsURL; }
    @JsonProperty("commits_url")
    public void setCommitsURL(String value) { this.commitsURL = value; }

    @JsonProperty("created_at")
    public OffsetDateTime getCreatedAt() { return createdAt; }
    @JsonProperty("created_at")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setCreatedAt(OffsetDateTime value) { this.createdAt = value; }

    @JsonProperty("deletions")
    public long getDeletions() { return deletions; }
    @JsonProperty("deletions")
    public void setDeletions(long value) { this.deletions = value; }

    @JsonProperty("diff_url")
    public String getDiffURL() { return diffURL; }
    @JsonProperty("diff_url")
    public void setDiffURL(String value) { this.diffURL = value; }

    @JsonProperty("head")
    public Base getHead() { return head; }
    @JsonProperty("head")
    public void setHead(Base value) { this.head = value; }

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

    @JsonProperty("_links")
    public Links getLinks() { return links; }
    @JsonProperty("_links")
    public void setLinks(Links value) { this.links = value; }

    @JsonProperty("locked")
    public boolean getLocked() { return locked; }
    @JsonProperty("locked")
    public void setLocked(boolean value) { this.locked = value; }

    @JsonProperty("maintainer_can_modify")
    public boolean getMaintainerCanModify() { return maintainerCanModify; }
    @JsonProperty("maintainer_can_modify")
    public void setMaintainerCanModify(boolean value) { this.maintainerCanModify = value; }

    @JsonProperty("merge_commit_sha")
    public String getMergeCommitSHA() { return mergeCommitSHA; }
    @JsonProperty("merge_commit_sha")
    public void setMergeCommitSHA(String value) { this.mergeCommitSHA = value; }

    @JsonProperty("mergeable")
    public Object getMergeable() { return mergeable; }
    @JsonProperty("mergeable")
    public void setMergeable(Object value) { this.mergeable = value; }

    @JsonProperty("mergeable_state")
    public String getMergeableState() { return mergeableState; }
    @JsonProperty("mergeable_state")
    public void setMergeableState(String value) { this.mergeableState = value; }

    @JsonProperty("merged")
    public boolean getMerged() { return merged; }
    @JsonProperty("merged")
    public void setMerged(boolean value) { this.merged = value; }

    @JsonProperty("merged_at")
    public OffsetDateTime getMergedAt() { return mergedAt; }
    @JsonProperty("merged_at")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setMergedAt(OffsetDateTime value) { this.mergedAt = value; }

    @JsonProperty("merged_by")
    public User getMergedBy() { return mergedBy; }
    @JsonProperty("merged_by")
    public void setMergedBy(User value) { this.mergedBy = value; }

    @JsonProperty("milestone")
    public Object getMilestone() { return milestone; }
    @JsonProperty("milestone")
    public void setMilestone(Object value) { this.milestone = value; }

    @JsonProperty("number")
    public long getNumber() { return number; }
    @JsonProperty("number")
    public void setNumber(long value) { this.number = value; }

    @JsonProperty("patch_url")
    public String getPatchURL() { return patchURL; }
    @JsonProperty("patch_url")
    public void setPatchURL(String value) { this.patchURL = value; }

    @JsonProperty("rebaseable")
    public Object getRebaseable() { return rebaseable; }
    @JsonProperty("rebaseable")
    public void setRebaseable(Object value) { this.rebaseable = value; }

    @JsonProperty("requested_reviewers")
    public List<Object> getRequestedReviewers() { return requestedReviewers; }
    @JsonProperty("requested_reviewers")
    public void setRequestedReviewers(List<Object> value) { this.requestedReviewers = value; }

    @JsonProperty("review_comment_url")
    public String getReviewCommentURL() { return reviewCommentURL; }
    @JsonProperty("review_comment_url")
    public void setReviewCommentURL(String value) { this.reviewCommentURL = value; }

    @JsonProperty("review_comments")
    public long getReviewComments() { return reviewComments; }
    @JsonProperty("review_comments")
    public void setReviewComments(long value) { this.reviewComments = value; }

    @JsonProperty("review_comments_url")
    public String getReviewCommentsURL() { return reviewCommentsURL; }
    @JsonProperty("review_comments_url")
    public void setReviewCommentsURL(String value) { this.reviewCommentsURL = value; }

    @JsonProperty("state")
    public String getState() { return state; }
    @JsonProperty("state")
    public void setState(String value) { this.state = value; }

    @JsonProperty("statuses_url")
    public String getStatusesURL() { return statusesURL; }
    @JsonProperty("statuses_url")
    public void setStatusesURL(String value) { this.statusesURL = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }

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
    public User getUser() { return user; }
    @JsonProperty("user")
    public void setUser(User value) { this.user = value; }
}

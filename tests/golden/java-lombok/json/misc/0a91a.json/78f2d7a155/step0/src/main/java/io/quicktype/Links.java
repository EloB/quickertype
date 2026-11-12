package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Links {
    private Comments comments;
    private Comments commits;
    private Comments html;
    private Comments issue;
    private Comments reviewComment;
    private Comments reviewComments;
    private Comments self;
    private Comments statuses;

    @JsonProperty("comments")
    public Comments getComments() { return comments; }
    @JsonProperty("comments")
    public void setComments(Comments value) { this.comments = value; }

    @JsonProperty("commits")
    public Comments getCommits() { return commits; }
    @JsonProperty("commits")
    public void setCommits(Comments value) { this.commits = value; }

    @JsonProperty("html")
    public Comments getHTML() { return html; }
    @JsonProperty("html")
    public void setHTML(Comments value) { this.html = value; }

    @JsonProperty("issue")
    public Comments getIssue() { return issue; }
    @JsonProperty("issue")
    public void setIssue(Comments value) { this.issue = value; }

    @JsonProperty("review_comment")
    public Comments getReviewComment() { return reviewComment; }
    @JsonProperty("review_comment")
    public void setReviewComment(Comments value) { this.reviewComment = value; }

    @JsonProperty("review_comments")
    public Comments getReviewComments() { return reviewComments; }
    @JsonProperty("review_comments")
    public void setReviewComments(Comments value) { this.reviewComments = value; }

    @JsonProperty("self")
    public Comments getSelf() { return self; }
    @JsonProperty("self")
    public void setSelf(Comments value) { this.self = value; }

    @JsonProperty("statuses")
    public Comments getStatuses() { return statuses; }
    @JsonProperty("statuses")
    public void setStatuses(Comments value) { this.statuses = value; }
}

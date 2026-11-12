package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;

public class BaseRepo {
    private String archiveURL;
    private String assigneesURL;
    private String blobsURL;
    private String branchesURL;
    private String cloneURL;
    private String collaboratorsURL;
    private String commentsURL;
    private String commitsURL;
    private String compareURL;
    private String contentsURL;
    private String contributorsURL;
    private OffsetDateTime createdAt;
    private String defaultBranch;
    private String deploymentsURL;
    private Object description;
    private String downloadsURL;
    private String eventsURL;
    private boolean fork;
    private long forks;
    private long forksCount;
    private String forksURL;
    private String fullName;
    private String gitCommitsURL;
    private String gitRefsURL;
    private String gitTagsURL;
    private String gitURL;
    private boolean hasDownloads;
    private boolean hasIssues;
    private boolean hasPages;
    private boolean hasProjects;
    private boolean hasWiki;
    private Object homepage;
    private String hooksURL;
    private String htmlURL;
    private long id;
    private String issueCommentURL;
    private String issueEventsURL;
    private String issuesURL;
    private String keysURL;
    private String labelsURL;
    private String language;
    private String languagesURL;
    private String mergesURL;
    private String milestonesURL;
    private Object mirrorURL;
    private String name;
    private String notificationsURL;
    private long openIssues;
    private long openIssuesCount;
    private MergedBy owner;
    private String pullsURL;
    private OffsetDateTime pushedAt;
    private String releasesURL;
    private boolean repoPrivate;
    private long size;
    private String sshURL;
    private long stargazersCount;
    private String stargazersURL;
    private String statusesURL;
    private String subscribersURL;
    private String subscriptionURL;
    private String svnURL;
    private String tagsURL;
    private String teamsURL;
    private String treesURL;
    private OffsetDateTime updatedAt;
    private String url;
    private long watchers;
    private long watchersCount;

    @JsonProperty("archive_url")
    public String getArchiveURL() { return archiveURL; }
    @JsonProperty("archive_url")
    public void setArchiveURL(String value) { this.archiveURL = value; }

    @JsonProperty("assignees_url")
    public String getAssigneesURL() { return assigneesURL; }
    @JsonProperty("assignees_url")
    public void setAssigneesURL(String value) { this.assigneesURL = value; }

    @JsonProperty("blobs_url")
    public String getBlobsURL() { return blobsURL; }
    @JsonProperty("blobs_url")
    public void setBlobsURL(String value) { this.blobsURL = value; }

    @JsonProperty("branches_url")
    public String getBranchesURL() { return branchesURL; }
    @JsonProperty("branches_url")
    public void setBranchesURL(String value) { this.branchesURL = value; }

    @JsonProperty("clone_url")
    public String getCloneURL() { return cloneURL; }
    @JsonProperty("clone_url")
    public void setCloneURL(String value) { this.cloneURL = value; }

    @JsonProperty("collaborators_url")
    public String getCollaboratorsURL() { return collaboratorsURL; }
    @JsonProperty("collaborators_url")
    public void setCollaboratorsURL(String value) { this.collaboratorsURL = value; }

    @JsonProperty("comments_url")
    public String getCommentsURL() { return commentsURL; }
    @JsonProperty("comments_url")
    public void setCommentsURL(String value) { this.commentsURL = value; }

    @JsonProperty("commits_url")
    public String getCommitsURL() { return commitsURL; }
    @JsonProperty("commits_url")
    public void setCommitsURL(String value) { this.commitsURL = value; }

    @JsonProperty("compare_url")
    public String getCompareURL() { return compareURL; }
    @JsonProperty("compare_url")
    public void setCompareURL(String value) { this.compareURL = value; }

    @JsonProperty("contents_url")
    public String getContentsURL() { return contentsURL; }
    @JsonProperty("contents_url")
    public void setContentsURL(String value) { this.contentsURL = value; }

    @JsonProperty("contributors_url")
    public String getContributorsURL() { return contributorsURL; }
    @JsonProperty("contributors_url")
    public void setContributorsURL(String value) { this.contributorsURL = value; }

    @JsonProperty("created_at")
    public OffsetDateTime getCreatedAt() { return createdAt; }
    @JsonProperty("created_at")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setCreatedAt(OffsetDateTime value) { this.createdAt = value; }

    @JsonProperty("default_branch")
    public String getDefaultBranch() { return defaultBranch; }
    @JsonProperty("default_branch")
    public void setDefaultBranch(String value) { this.defaultBranch = value; }

    @JsonProperty("deployments_url")
    public String getDeploymentsURL() { return deploymentsURL; }
    @JsonProperty("deployments_url")
    public void setDeploymentsURL(String value) { this.deploymentsURL = value; }

    @JsonProperty("description")
    public Object getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(Object value) { this.description = value; }

    @JsonProperty("downloads_url")
    public String getDownloadsURL() { return downloadsURL; }
    @JsonProperty("downloads_url")
    public void setDownloadsURL(String value) { this.downloadsURL = value; }

    @JsonProperty("events_url")
    public String getEventsURL() { return eventsURL; }
    @JsonProperty("events_url")
    public void setEventsURL(String value) { this.eventsURL = value; }

    @JsonProperty("fork")
    public boolean getFork() { return fork; }
    @JsonProperty("fork")
    public void setFork(boolean value) { this.fork = value; }

    @JsonProperty("forks")
    public long getForks() { return forks; }
    @JsonProperty("forks")
    public void setForks(long value) { this.forks = value; }

    @JsonProperty("forks_count")
    public long getForksCount() { return forksCount; }
    @JsonProperty("forks_count")
    public void setForksCount(long value) { this.forksCount = value; }

    @JsonProperty("forks_url")
    public String getForksURL() { return forksURL; }
    @JsonProperty("forks_url")
    public void setForksURL(String value) { this.forksURL = value; }

    @JsonProperty("full_name")
    public String getFullName() { return fullName; }
    @JsonProperty("full_name")
    public void setFullName(String value) { this.fullName = value; }

    @JsonProperty("git_commits_url")
    public String getGitCommitsURL() { return gitCommitsURL; }
    @JsonProperty("git_commits_url")
    public void setGitCommitsURL(String value) { this.gitCommitsURL = value; }

    @JsonProperty("git_refs_url")
    public String getGitRefsURL() { return gitRefsURL; }
    @JsonProperty("git_refs_url")
    public void setGitRefsURL(String value) { this.gitRefsURL = value; }

    @JsonProperty("git_tags_url")
    public String getGitTagsURL() { return gitTagsURL; }
    @JsonProperty("git_tags_url")
    public void setGitTagsURL(String value) { this.gitTagsURL = value; }

    @JsonProperty("git_url")
    public String getGitURL() { return gitURL; }
    @JsonProperty("git_url")
    public void setGitURL(String value) { this.gitURL = value; }

    @JsonProperty("has_downloads")
    public boolean getHasDownloads() { return hasDownloads; }
    @JsonProperty("has_downloads")
    public void setHasDownloads(boolean value) { this.hasDownloads = value; }

    @JsonProperty("has_issues")
    public boolean getHasIssues() { return hasIssues; }
    @JsonProperty("has_issues")
    public void setHasIssues(boolean value) { this.hasIssues = value; }

    @JsonProperty("has_pages")
    public boolean getHasPages() { return hasPages; }
    @JsonProperty("has_pages")
    public void setHasPages(boolean value) { this.hasPages = value; }

    @JsonProperty("has_projects")
    public boolean getHasProjects() { return hasProjects; }
    @JsonProperty("has_projects")
    public void setHasProjects(boolean value) { this.hasProjects = value; }

    @JsonProperty("has_wiki")
    public boolean getHasWiki() { return hasWiki; }
    @JsonProperty("has_wiki")
    public void setHasWiki(boolean value) { this.hasWiki = value; }

    @JsonProperty("homepage")
    public Object getHomepage() { return homepage; }
    @JsonProperty("homepage")
    public void setHomepage(Object value) { this.homepage = value; }

    @JsonProperty("hooks_url")
    public String getHooksURL() { return hooksURL; }
    @JsonProperty("hooks_url")
    public void setHooksURL(String value) { this.hooksURL = value; }

    @JsonProperty("html_url")
    public String getHTMLURL() { return htmlURL; }
    @JsonProperty("html_url")
    public void setHTMLURL(String value) { this.htmlURL = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("issue_comment_url")
    public String getIssueCommentURL() { return issueCommentURL; }
    @JsonProperty("issue_comment_url")
    public void setIssueCommentURL(String value) { this.issueCommentURL = value; }

    @JsonProperty("issue_events_url")
    public String getIssueEventsURL() { return issueEventsURL; }
    @JsonProperty("issue_events_url")
    public void setIssueEventsURL(String value) { this.issueEventsURL = value; }

    @JsonProperty("issues_url")
    public String getIssuesURL() { return issuesURL; }
    @JsonProperty("issues_url")
    public void setIssuesURL(String value) { this.issuesURL = value; }

    @JsonProperty("keys_url")
    public String getKeysURL() { return keysURL; }
    @JsonProperty("keys_url")
    public void setKeysURL(String value) { this.keysURL = value; }

    @JsonProperty("labels_url")
    public String getLabelsURL() { return labelsURL; }
    @JsonProperty("labels_url")
    public void setLabelsURL(String value) { this.labelsURL = value; }

    @JsonProperty("language")
    public String getLanguage() { return language; }
    @JsonProperty("language")
    public void setLanguage(String value) { this.language = value; }

    @JsonProperty("languages_url")
    public String getLanguagesURL() { return languagesURL; }
    @JsonProperty("languages_url")
    public void setLanguagesURL(String value) { this.languagesURL = value; }

    @JsonProperty("merges_url")
    public String getMergesURL() { return mergesURL; }
    @JsonProperty("merges_url")
    public void setMergesURL(String value) { this.mergesURL = value; }

    @JsonProperty("milestones_url")
    public String getMilestonesURL() { return milestonesURL; }
    @JsonProperty("milestones_url")
    public void setMilestonesURL(String value) { this.milestonesURL = value; }

    @JsonProperty("mirror_url")
    public Object getMirrorURL() { return mirrorURL; }
    @JsonProperty("mirror_url")
    public void setMirrorURL(Object value) { this.mirrorURL = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("notifications_url")
    public String getNotificationsURL() { return notificationsURL; }
    @JsonProperty("notifications_url")
    public void setNotificationsURL(String value) { this.notificationsURL = value; }

    @JsonProperty("open_issues")
    public long getOpenIssues() { return openIssues; }
    @JsonProperty("open_issues")
    public void setOpenIssues(long value) { this.openIssues = value; }

    @JsonProperty("open_issues_count")
    public long getOpenIssuesCount() { return openIssuesCount; }
    @JsonProperty("open_issues_count")
    public void setOpenIssuesCount(long value) { this.openIssuesCount = value; }

    @JsonProperty("owner")
    public MergedBy getOwner() { return owner; }
    @JsonProperty("owner")
    public void setOwner(MergedBy value) { this.owner = value; }

    @JsonProperty("pulls_url")
    public String getPullsURL() { return pullsURL; }
    @JsonProperty("pulls_url")
    public void setPullsURL(String value) { this.pullsURL = value; }

    @JsonProperty("pushed_at")
    public OffsetDateTime getPushedAt() { return pushedAt; }
    @JsonProperty("pushed_at")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setPushedAt(OffsetDateTime value) { this.pushedAt = value; }

    @JsonProperty("releases_url")
    public String getReleasesURL() { return releasesURL; }
    @JsonProperty("releases_url")
    public void setReleasesURL(String value) { this.releasesURL = value; }

    @JsonProperty("private")
    public boolean getRepoPrivate() { return repoPrivate; }
    @JsonProperty("private")
    public void setRepoPrivate(boolean value) { this.repoPrivate = value; }

    @JsonProperty("size")
    public long getSize() { return size; }
    @JsonProperty("size")
    public void setSize(long value) { this.size = value; }

    @JsonProperty("ssh_url")
    public String getSSHURL() { return sshURL; }
    @JsonProperty("ssh_url")
    public void setSSHURL(String value) { this.sshURL = value; }

    @JsonProperty("stargazers_count")
    public long getStargazersCount() { return stargazersCount; }
    @JsonProperty("stargazers_count")
    public void setStargazersCount(long value) { this.stargazersCount = value; }

    @JsonProperty("stargazers_url")
    public String getStargazersURL() { return stargazersURL; }
    @JsonProperty("stargazers_url")
    public void setStargazersURL(String value) { this.stargazersURL = value; }

    @JsonProperty("statuses_url")
    public String getStatusesURL() { return statusesURL; }
    @JsonProperty("statuses_url")
    public void setStatusesURL(String value) { this.statusesURL = value; }

    @JsonProperty("subscribers_url")
    public String getSubscribersURL() { return subscribersURL; }
    @JsonProperty("subscribers_url")
    public void setSubscribersURL(String value) { this.subscribersURL = value; }

    @JsonProperty("subscription_url")
    public String getSubscriptionURL() { return subscriptionURL; }
    @JsonProperty("subscription_url")
    public void setSubscriptionURL(String value) { this.subscriptionURL = value; }

    @JsonProperty("svn_url")
    public String getSvnURL() { return svnURL; }
    @JsonProperty("svn_url")
    public void setSvnURL(String value) { this.svnURL = value; }

    @JsonProperty("tags_url")
    public String getTagsURL() { return tagsURL; }
    @JsonProperty("tags_url")
    public void setTagsURL(String value) { this.tagsURL = value; }

    @JsonProperty("teams_url")
    public String getTeamsURL() { return teamsURL; }
    @JsonProperty("teams_url")
    public void setTeamsURL(String value) { this.teamsURL = value; }

    @JsonProperty("trees_url")
    public String getTreesURL() { return treesURL; }
    @JsonProperty("trees_url")
    public void setTreesURL(String value) { this.treesURL = value; }

    @JsonProperty("updated_at")
    public OffsetDateTime getUpdatedAt() { return updatedAt; }
    @JsonProperty("updated_at")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setUpdatedAt(OffsetDateTime value) { this.updatedAt = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }

    @JsonProperty("watchers")
    public long getWatchers() { return watchers; }
    @JsonProperty("watchers")
    public void setWatchers(long value) { this.watchers = value; }

    @JsonProperty("watchers_count")
    public long getWatchersCount() { return watchersCount; }
    @JsonProperty("watchers_count")
    public void setWatchersCount(long value) { this.watchersCount = value; }
}

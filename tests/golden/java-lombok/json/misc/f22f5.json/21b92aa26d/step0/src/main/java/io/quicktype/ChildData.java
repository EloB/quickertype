package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class ChildData {
    private Object approvedAtUTC;
    private Object approvedBy;
    private boolean archived;
    private String author;
    private Object authorFlairCSSClass;
    private Object authorFlairText;
    private Object bannedAtUTC;
    private Object bannedBy;
    private boolean brandSafe;
    private boolean canGild;
    private boolean canModPost;
    private boolean clicked;
    private boolean contestMode;
    private double created;
    private double createdUTC;
    private Object distinguished;
    private String domain;
    private long downs;
    private boolean edited;
    private long gilded;
    private boolean hidden;
    private boolean hideScore;
    private String id;
    private boolean isSelf;
    private boolean isVideo;
    private Object likes;
    private String linkFlairCSSClass;
    private String linkFlairText;
    private boolean locked;
    private Object media;
    private MediaEmbed mediaEmbed;
    private List<Object> modReports;
    private String name;
    private long numComments;
    private Object numReports;
    private boolean over18;
    private String permalink;
    private boolean quarantine;
    private Object removalReason;
    private Object reportReasons;
    private boolean saved;
    private long score;
    private Object secureMedia;
    private MediaEmbed secureMediaEmbed;
    private String selftext;
    private Object selftextHTML;
    private boolean spoiler;
    private boolean stickied;
    private Subreddit subreddit;
    private SubredditID subredditID;
    private SubredditNamePrefixed subredditNamePrefixed;
    private SubredditType subredditType;
    private Object suggestedSort;
    private String thumbnail;
    private String title;
    private long ups;
    private String url;
    private List<Object> userReports;
    private Object viewCount;
    private boolean visited;

    @JsonProperty("approved_at_utc")
    public Object getApprovedAtUTC() { return approvedAtUTC; }
    @JsonProperty("approved_at_utc")
    public void setApprovedAtUTC(Object value) { this.approvedAtUTC = value; }

    @JsonProperty("approved_by")
    public Object getApprovedBy() { return approvedBy; }
    @JsonProperty("approved_by")
    public void setApprovedBy(Object value) { this.approvedBy = value; }

    @JsonProperty("archived")
    public boolean getArchived() { return archived; }
    @JsonProperty("archived")
    public void setArchived(boolean value) { this.archived = value; }

    @JsonProperty("author")
    public String getAuthor() { return author; }
    @JsonProperty("author")
    public void setAuthor(String value) { this.author = value; }

    @JsonProperty("author_flair_css_class")
    public Object getAuthorFlairCSSClass() { return authorFlairCSSClass; }
    @JsonProperty("author_flair_css_class")
    public void setAuthorFlairCSSClass(Object value) { this.authorFlairCSSClass = value; }

    @JsonProperty("author_flair_text")
    public Object getAuthorFlairText() { return authorFlairText; }
    @JsonProperty("author_flair_text")
    public void setAuthorFlairText(Object value) { this.authorFlairText = value; }

    @JsonProperty("banned_at_utc")
    public Object getBannedAtUTC() { return bannedAtUTC; }
    @JsonProperty("banned_at_utc")
    public void setBannedAtUTC(Object value) { this.bannedAtUTC = value; }

    @JsonProperty("banned_by")
    public Object getBannedBy() { return bannedBy; }
    @JsonProperty("banned_by")
    public void setBannedBy(Object value) { this.bannedBy = value; }

    @JsonProperty("brand_safe")
    public boolean getBrandSafe() { return brandSafe; }
    @JsonProperty("brand_safe")
    public void setBrandSafe(boolean value) { this.brandSafe = value; }

    @JsonProperty("can_gild")
    public boolean getCanGild() { return canGild; }
    @JsonProperty("can_gild")
    public void setCanGild(boolean value) { this.canGild = value; }

    @JsonProperty("can_mod_post")
    public boolean getCanModPost() { return canModPost; }
    @JsonProperty("can_mod_post")
    public void setCanModPost(boolean value) { this.canModPost = value; }

    @JsonProperty("clicked")
    public boolean getClicked() { return clicked; }
    @JsonProperty("clicked")
    public void setClicked(boolean value) { this.clicked = value; }

    @JsonProperty("contest_mode")
    public boolean getContestMode() { return contestMode; }
    @JsonProperty("contest_mode")
    public void setContestMode(boolean value) { this.contestMode = value; }

    @JsonProperty("created")
    public double getCreated() { return created; }
    @JsonProperty("created")
    public void setCreated(double value) { this.created = value; }

    @JsonProperty("created_utc")
    public double getCreatedUTC() { return createdUTC; }
    @JsonProperty("created_utc")
    public void setCreatedUTC(double value) { this.createdUTC = value; }

    @JsonProperty("distinguished")
    public Object getDistinguished() { return distinguished; }
    @JsonProperty("distinguished")
    public void setDistinguished(Object value) { this.distinguished = value; }

    @JsonProperty("domain")
    public String getDomain() { return domain; }
    @JsonProperty("domain")
    public void setDomain(String value) { this.domain = value; }

    @JsonProperty("downs")
    public long getDowns() { return downs; }
    @JsonProperty("downs")
    public void setDowns(long value) { this.downs = value; }

    @JsonProperty("edited")
    public boolean getEdited() { return edited; }
    @JsonProperty("edited")
    public void setEdited(boolean value) { this.edited = value; }

    @JsonProperty("gilded")
    public long getGilded() { return gilded; }
    @JsonProperty("gilded")
    public void setGilded(long value) { this.gilded = value; }

    @JsonProperty("hidden")
    public boolean getHidden() { return hidden; }
    @JsonProperty("hidden")
    public void setHidden(boolean value) { this.hidden = value; }

    @JsonProperty("hide_score")
    public boolean getHideScore() { return hideScore; }
    @JsonProperty("hide_score")
    public void setHideScore(boolean value) { this.hideScore = value; }

    @JsonProperty("id")
    public String getID() { return id; }
    @JsonProperty("id")
    public void setID(String value) { this.id = value; }

    @JsonProperty("is_self")
    public boolean getIsSelf() { return isSelf; }
    @JsonProperty("is_self")
    public void setIsSelf(boolean value) { this.isSelf = value; }

    @JsonProperty("is_video")
    public boolean getIsVideo() { return isVideo; }
    @JsonProperty("is_video")
    public void setIsVideo(boolean value) { this.isVideo = value; }

    @JsonProperty("likes")
    public Object getLikes() { return likes; }
    @JsonProperty("likes")
    public void setLikes(Object value) { this.likes = value; }

    @JsonProperty("link_flair_css_class")
    public String getLinkFlairCSSClass() { return linkFlairCSSClass; }
    @JsonProperty("link_flair_css_class")
    public void setLinkFlairCSSClass(String value) { this.linkFlairCSSClass = value; }

    @JsonProperty("link_flair_text")
    public String getLinkFlairText() { return linkFlairText; }
    @JsonProperty("link_flair_text")
    public void setLinkFlairText(String value) { this.linkFlairText = value; }

    @JsonProperty("locked")
    public boolean getLocked() { return locked; }
    @JsonProperty("locked")
    public void setLocked(boolean value) { this.locked = value; }

    @JsonProperty("media")
    public Object getMedia() { return media; }
    @JsonProperty("media")
    public void setMedia(Object value) { this.media = value; }

    @JsonProperty("media_embed")
    public MediaEmbed getMediaEmbed() { return mediaEmbed; }
    @JsonProperty("media_embed")
    public void setMediaEmbed(MediaEmbed value) { this.mediaEmbed = value; }

    @JsonProperty("mod_reports")
    public List<Object> getModReports() { return modReports; }
    @JsonProperty("mod_reports")
    public void setModReports(List<Object> value) { this.modReports = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("num_comments")
    public long getNumComments() { return numComments; }
    @JsonProperty("num_comments")
    public void setNumComments(long value) { this.numComments = value; }

    @JsonProperty("num_reports")
    public Object getNumReports() { return numReports; }
    @JsonProperty("num_reports")
    public void setNumReports(Object value) { this.numReports = value; }

    @JsonProperty("over_18")
    public boolean getOver18() { return over18; }
    @JsonProperty("over_18")
    public void setOver18(boolean value) { this.over18 = value; }

    @JsonProperty("permalink")
    public String getPermalink() { return permalink; }
    @JsonProperty("permalink")
    public void setPermalink(String value) { this.permalink = value; }

    @JsonProperty("quarantine")
    public boolean getQuarantine() { return quarantine; }
    @JsonProperty("quarantine")
    public void setQuarantine(boolean value) { this.quarantine = value; }

    @JsonProperty("removal_reason")
    public Object getRemovalReason() { return removalReason; }
    @JsonProperty("removal_reason")
    public void setRemovalReason(Object value) { this.removalReason = value; }

    @JsonProperty("report_reasons")
    public Object getReportReasons() { return reportReasons; }
    @JsonProperty("report_reasons")
    public void setReportReasons(Object value) { this.reportReasons = value; }

    @JsonProperty("saved")
    public boolean getSaved() { return saved; }
    @JsonProperty("saved")
    public void setSaved(boolean value) { this.saved = value; }

    @JsonProperty("score")
    public long getScore() { return score; }
    @JsonProperty("score")
    public void setScore(long value) { this.score = value; }

    @JsonProperty("secure_media")
    public Object getSecureMedia() { return secureMedia; }
    @JsonProperty("secure_media")
    public void setSecureMedia(Object value) { this.secureMedia = value; }

    @JsonProperty("secure_media_embed")
    public MediaEmbed getSecureMediaEmbed() { return secureMediaEmbed; }
    @JsonProperty("secure_media_embed")
    public void setSecureMediaEmbed(MediaEmbed value) { this.secureMediaEmbed = value; }

    @JsonProperty("selftext")
    public String getSelftext() { return selftext; }
    @JsonProperty("selftext")
    public void setSelftext(String value) { this.selftext = value; }

    @JsonProperty("selftext_html")
    public Object getSelftextHTML() { return selftextHTML; }
    @JsonProperty("selftext_html")
    public void setSelftextHTML(Object value) { this.selftextHTML = value; }

    @JsonProperty("spoiler")
    public boolean getSpoiler() { return spoiler; }
    @JsonProperty("spoiler")
    public void setSpoiler(boolean value) { this.spoiler = value; }

    @JsonProperty("stickied")
    public boolean getStickied() { return stickied; }
    @JsonProperty("stickied")
    public void setStickied(boolean value) { this.stickied = value; }

    @JsonProperty("subreddit")
    public Subreddit getSubreddit() { return subreddit; }
    @JsonProperty("subreddit")
    public void setSubreddit(Subreddit value) { this.subreddit = value; }

    @JsonProperty("subreddit_id")
    public SubredditID getSubredditID() { return subredditID; }
    @JsonProperty("subreddit_id")
    public void setSubredditID(SubredditID value) { this.subredditID = value; }

    @JsonProperty("subreddit_name_prefixed")
    public SubredditNamePrefixed getSubredditNamePrefixed() { return subredditNamePrefixed; }
    @JsonProperty("subreddit_name_prefixed")
    public void setSubredditNamePrefixed(SubredditNamePrefixed value) { this.subredditNamePrefixed = value; }

    @JsonProperty("subreddit_type")
    public SubredditType getSubredditType() { return subredditType; }
    @JsonProperty("subreddit_type")
    public void setSubredditType(SubredditType value) { this.subredditType = value; }

    @JsonProperty("suggested_sort")
    public Object getSuggestedSort() { return suggestedSort; }
    @JsonProperty("suggested_sort")
    public void setSuggestedSort(Object value) { this.suggestedSort = value; }

    @JsonProperty("thumbnail")
    public String getThumbnail() { return thumbnail; }
    @JsonProperty("thumbnail")
    public void setThumbnail(String value) { this.thumbnail = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }

    @JsonProperty("ups")
    public long getUPS() { return ups; }
    @JsonProperty("ups")
    public void setUPS(long value) { this.ups = value; }

    @JsonProperty("url")
    public String getURL() { return url; }
    @JsonProperty("url")
    public void setURL(String value) { this.url = value; }

    @JsonProperty("user_reports")
    public List<Object> getUserReports() { return userReports; }
    @JsonProperty("user_reports")
    public void setUserReports(List<Object> value) { this.userReports = value; }

    @JsonProperty("view_count")
    public Object getViewCount() { return viewCount; }
    @JsonProperty("view_count")
    public void setViewCount(Object value) { this.viewCount = value; }

    @JsonProperty("visited")
    public boolean getVisited() { return visited; }
    @JsonProperty("visited")
    public void setVisited(boolean value) { this.visited = value; }
}

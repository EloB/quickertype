package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.LocalDate;
import java.util.List;

public class Result {
    private long activeScreens;
    private List<Collection> collections;
    private List<Detail> details;
    private long duration;
    private FavMovie favMovie;
    private long id;
    private List<Image> images;
    private ResultLanguage language;
    private LocalDate releaseDate;
    private long stars;
    private List<Object> tags;
    private String title;
    private List<Video> videos;
    private VoteScore voteScore;
    private long watches;

    @JsonProperty("active_screens")
    public long getActiveScreens() { return activeScreens; }
    @JsonProperty("active_screens")
    public void setActiveScreens(long value) { this.activeScreens = value; }

    @JsonProperty("collections")
    public List<Collection> getCollections() { return collections; }
    @JsonProperty("collections")
    public void setCollections(List<Collection> value) { this.collections = value; }

    @JsonProperty("details")
    public List<Detail> getDetails() { return details; }
    @JsonProperty("details")
    public void setDetails(List<Detail> value) { this.details = value; }

    @JsonProperty("duration")
    public long getDuration() { return duration; }
    @JsonProperty("duration")
    public void setDuration(long value) { this.duration = value; }

    @JsonProperty("fav_movie")
    public FavMovie getFavMovie() { return favMovie; }
    @JsonProperty("fav_movie")
    public void setFavMovie(FavMovie value) { this.favMovie = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("images")
    public List<Image> getImages() { return images; }
    @JsonProperty("images")
    public void setImages(List<Image> value) { this.images = value; }

    @JsonProperty("language")
    public ResultLanguage getLanguage() { return language; }
    @JsonProperty("language")
    public void setLanguage(ResultLanguage value) { this.language = value; }

    @JsonProperty("release_date")
    public LocalDate getReleaseDate() { return releaseDate; }
    @JsonProperty("release_date")
    public void setReleaseDate(LocalDate value) { this.releaseDate = value; }

    @JsonProperty("stars")
    public long getStars() { return stars; }
    @JsonProperty("stars")
    public void setStars(long value) { this.stars = value; }

    @JsonProperty("tags")
    public List<Object> getTags() { return tags; }
    @JsonProperty("tags")
    public void setTags(List<Object> value) { this.tags = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }

    @JsonProperty("videos")
    public List<Video> getVideos() { return videos; }
    @JsonProperty("videos")
    public void setVideos(List<Video> value) { this.videos = value; }

    @JsonProperty("vote_score")
    public VoteScore getVoteScore() { return voteScore; }
    @JsonProperty("vote_score")
    public void setVoteScore(VoteScore value) { this.voteScore = value; }

    @JsonProperty("watches")
    public long getWatches() { return watches; }
    @JsonProperty("watches")
    public void setWatches(long value) { this.watches = value; }
}

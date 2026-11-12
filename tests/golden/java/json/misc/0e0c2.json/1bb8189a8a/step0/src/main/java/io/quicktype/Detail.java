package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Detail {
    private String cast;
    private String director;
    private long id;
    private DetailLanguage language;
    private String storyline;
    private String tagline;
    private String title;

    @JsonProperty("cast")
    public String getCast() { return cast; }
    @JsonProperty("cast")
    public void setCast(String value) { this.cast = value; }

    @JsonProperty("director")
    public String getDirector() { return director; }
    @JsonProperty("director")
    public void setDirector(String value) { this.director = value; }

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("language")
    public DetailLanguage getLanguage() { return language; }
    @JsonProperty("language")
    public void setLanguage(DetailLanguage value) { this.language = value; }

    @JsonProperty("storyline")
    public String getStoryline() { return storyline; }
    @JsonProperty("storyline")
    public void setStoryline(String value) { this.storyline = value; }

    @JsonProperty("tagline")
    public String getTagline() { return tagline; }
    @JsonProperty("tagline")
    public void setTagline(String value) { this.tagline = value; }

    @JsonProperty("title")
    public String getTitle() { return title; }
    @JsonProperty("title")
    public void setTitle(String value) { this.title = value; }
}

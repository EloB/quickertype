package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String group;
    private String movie;
    private String movieImage;
    private String theater;

    @JsonProperty("group")
    public String getGroup() { return group; }
    @JsonProperty("group")
    public void setGroup(String value) { this.group = value; }

    @JsonProperty("movie")
    public String getMovie() { return movie; }
    @JsonProperty("movie")
    public void setMovie(String value) { this.movie = value; }

    @JsonProperty("movie-image")
    public String getMovieImage() { return movieImage; }
    @JsonProperty("movie-image")
    public void setMovieImage(String value) { this.movieImage = value; }

    @JsonProperty("theater")
    public String getTheater() { return theater; }
    @JsonProperty("theater")
    public void setTheater(String value) { this.theater = value; }
}

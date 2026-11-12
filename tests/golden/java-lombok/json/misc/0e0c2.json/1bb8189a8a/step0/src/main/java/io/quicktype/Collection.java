package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Collection {
    private long id;
    private List<Long> movies;
    private String name;
    private String slug;

    @JsonProperty("id")
    public long getID() { return id; }
    @JsonProperty("id")
    public void setID(long value) { this.id = value; }

    @JsonProperty("movies")
    public List<Long> getMovies() { return movies; }
    @JsonProperty("movies")
    public void setMovies(List<Long> value) { this.movies = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("slug")
    public String getSlug() { return slug; }
    @JsonProperty("slug")
    public void setSlug(String value) { this.slug = value; }
}

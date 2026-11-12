package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Useraveragerating {
    private List<LinkElement> links;
    private long numcomments;
    private String rating;

    @JsonProperty("links")
    public List<LinkElement> getLinks() { return links; }
    @JsonProperty("links")
    public void setLinks(List<LinkElement> value) { this.links = value; }

    @JsonProperty("numcomments")
    public long getNumcomments() { return numcomments; }
    @JsonProperty("numcomments")
    public void setNumcomments(long value) { this.numcomments = value; }

    @JsonProperty("rating")
    public String getRating() { return rating; }
    @JsonProperty("rating")
    public void setRating(String value) { this.rating = value; }
}

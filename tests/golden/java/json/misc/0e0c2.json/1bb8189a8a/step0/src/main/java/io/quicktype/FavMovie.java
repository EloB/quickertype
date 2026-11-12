package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class FavMovie {
    private boolean follow;
    private boolean star;
    private boolean watched;

    @JsonProperty("follow")
    public boolean getFollow() { return follow; }
    @JsonProperty("follow")
    public void setFollow(boolean value) { this.follow = value; }

    @JsonProperty("star")
    public boolean getStar() { return star; }
    @JsonProperty("star")
    public void setStar(boolean value) { this.star = value; }

    @JsonProperty("watched")
    public boolean getWatched() { return watched; }
    @JsonProperty("watched")
    public void setWatched(boolean value) { this.watched = value; }
}

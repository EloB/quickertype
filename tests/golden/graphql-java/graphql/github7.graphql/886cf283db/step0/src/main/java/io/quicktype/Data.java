package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Data {
    private User viewer;

    @JsonProperty("viewer")
    public User getViewer() { return viewer; }
    @JsonProperty("viewer")
    public void setViewer(User value) { this.viewer = value; }
}

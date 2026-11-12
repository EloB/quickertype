package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class AccessPoints {
    private String newView;

    @JsonProperty("new_view")
    public String getNewView() { return newView; }
    @JsonProperty("new_view")
    public void setNewView(String value) { this.newView = value; }
}

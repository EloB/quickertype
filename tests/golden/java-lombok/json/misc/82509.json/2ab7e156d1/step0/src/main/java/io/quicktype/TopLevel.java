package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private String origin;

    @JsonProperty("origin")
    public String getOrigin() { return origin; }
    @JsonProperty("origin")
    public void setOrigin(String value) { this.origin = value; }
}

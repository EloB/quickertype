package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Specification {
    private List<LinkElement> links;

    @JsonProperty("links")
    public List<LinkElement> getLinks() { return links; }
    @JsonProperty("links")
    public void setLinks(List<LinkElement> value) { this.links = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class LinkElement {
    private LinkLink link;

    @JsonProperty("link")
    public LinkLink getLink() { return link; }
    @JsonProperty("link")
    public void setLink(LinkLink value) { this.link = value; }
}

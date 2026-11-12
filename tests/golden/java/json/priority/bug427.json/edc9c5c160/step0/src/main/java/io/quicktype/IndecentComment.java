package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class IndecentComment {
    private String shortText;
    private List<Tag> tags;

    @JsonProperty("shortText")
    public String getShortText() { return shortText; }
    @JsonProperty("shortText")
    public void setShortText(String value) { this.shortText = value; }

    @JsonProperty("tags")
    public List<Tag> getTags() { return tags; }
    @JsonProperty("tags")
    public void setTags(List<Tag> value) { this.tags = value; }
}

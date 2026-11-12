package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Reaction {
    private ReactionContent content;

    @JsonProperty("content")
    public ReactionContent getContent() { return content; }
    @JsonProperty("content")
    public void setContent(ReactionContent value) { this.content = value; }
}

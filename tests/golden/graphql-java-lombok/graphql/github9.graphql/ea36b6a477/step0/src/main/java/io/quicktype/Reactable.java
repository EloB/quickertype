package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class Reactable {
    private boolean viewerCanReact;
    private List<Reaction> reactionGroups;

    @JsonProperty("viewerCanReact")
    public boolean getViewerCanReact() { return viewerCanReact; }
    @JsonProperty("viewerCanReact")
    public void setViewerCanReact(boolean value) { this.viewerCanReact = value; }

    @JsonProperty("reactionGroups")
    public List<Reaction> getReactionGroups() { return reactionGroups; }
    @JsonProperty("reactionGroups")
    public void setReactionGroups(List<Reaction> value) { this.reactionGroups = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class PullRequestConnection {
    private List<PullRequest> nodes;

    @JsonProperty("nodes")
    public List<PullRequest> getNodes() { return nodes; }
    @JsonProperty("nodes")
    public void setNodes(List<PullRequest> value) { this.nodes = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class RepositoryEdge {
    private Repository node;

    @JsonProperty("node")
    public Repository getNode() { return node; }
    @JsonProperty("node")
    public void setNode(Repository value) { this.node = value; }
}

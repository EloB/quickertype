package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class RepositoryConnection {
    private List<RepositoryEdge> edges;

    @JsonProperty("edges")
    public List<RepositoryEdge> getEdges() { return edges; }
    @JsonProperty("edges")
    public void setEdges(List<RepositoryEdge> value) { this.edges = value; }
}

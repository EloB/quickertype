package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class RepositoryConnection {
    private long totalCount;
    private List<Repository> nodes;

    @JsonProperty("totalCount")
    public long getTotalCount() { return totalCount; }
    @JsonProperty("totalCount")
    public void setTotalCount(long value) { this.totalCount = value; }

    @JsonProperty("nodes")
    public List<Repository> getNodes() { return nodes; }
    @JsonProperty("nodes")
    public void setNodes(List<Repository> value) { this.nodes = value; }
}

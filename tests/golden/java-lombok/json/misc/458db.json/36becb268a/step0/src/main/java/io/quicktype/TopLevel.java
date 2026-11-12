package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private Metadata metadata;
    private List<Result> results;

    @JsonProperty("metadata")
    public Metadata getMetadata() { return metadata; }
    @JsonProperty("metadata")
    public void setMetadata(Metadata value) { this.metadata = value; }

    @JsonProperty("results")
    public List<Result> getResults() { return results; }
    @JsonProperty("results")
    public void setResults(List<Result> value) { this.results = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private List<Result> results;

    @JsonProperty("results")
    public List<Result> getResults() { return results; }
    @JsonProperty("results")
    public void setResults(List<Result> value) { this.results = value; }
}

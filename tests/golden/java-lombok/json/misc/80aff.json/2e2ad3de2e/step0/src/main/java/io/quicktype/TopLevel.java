package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.util.List;

public class TopLevel {
    private long count;
    private Facets facets;
    private long limit;
    private boolean next;
    private long offset;
    private boolean previous;
    private List<Result> results;

    @JsonProperty("count")
    public long getCount() { return count; }
    @JsonProperty("count")
    public void setCount(long value) { this.count = value; }

    @JsonProperty("facets")
    public Facets getFacets() { return facets; }
    @JsonProperty("facets")
    public void setFacets(Facets value) { this.facets = value; }

    @JsonProperty("limit")
    public long getLimit() { return limit; }
    @JsonProperty("limit")
    public void setLimit(long value) { this.limit = value; }

    @JsonProperty("next")
    public boolean getNext() { return next; }
    @JsonProperty("next")
    public void setNext(boolean value) { this.next = value; }

    @JsonProperty("offset")
    public long getOffset() { return offset; }
    @JsonProperty("offset")
    public void setOffset(long value) { this.offset = value; }

    @JsonProperty("previous")
    public boolean getPrevious() { return previous; }
    @JsonProperty("previous")
    public void setPrevious(boolean value) { this.previous = value; }

    @JsonProperty("results")
    public List<Result> getResults() { return results; }
    @JsonProperty("results")
    public void setResults(List<Result> value) { this.results = value; }
}

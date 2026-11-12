package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Query query;

    @JsonProperty("query")
    public Query getQuery() { return query; }
    @JsonProperty("query")
    public void setQuery(Query value) { this.query = value; }
}

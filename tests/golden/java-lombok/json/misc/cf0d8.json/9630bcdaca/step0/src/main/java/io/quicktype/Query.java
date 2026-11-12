package io.quicktype;

import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;

public class Query {
    private long count;
    private OffsetDateTime created;
    private String lang;
    private Results results;

    @JsonProperty("count")
    public long getCount() { return count; }
    @JsonProperty("count")
    public void setCount(long value) { this.count = value; }

    @JsonProperty("created")
    public OffsetDateTime getCreated() { return created; }
    @JsonProperty("created")
    @JsonSetter(nulls = Nulls.FAIL)
    public void setCreated(OffsetDateTime value) { this.created = value; }

    @JsonProperty("lang")
    public String getLang() { return lang; }
    @JsonProperty("lang")
    public void setLang(String value) { this.lang = value; }

    @JsonProperty("results")
    public Results getResults() { return results; }
    @JsonProperty("results")
    public void setResults(Results value) { this.results = value; }
}

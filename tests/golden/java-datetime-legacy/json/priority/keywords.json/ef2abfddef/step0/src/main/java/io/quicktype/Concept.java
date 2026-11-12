package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Concept {
    private long concept;

    @JsonProperty("concept")
    public long getConcept() { return concept; }
    @JsonProperty("concept")
    public void setConcept(long value) { this.concept = value; }
}

package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevel {
    private Hints hints;
    private Labels labels;

    @JsonProperty("Hints")
    public Hints getHints() { return hints; }
    @JsonProperty("Hints")
    public void setHints(Hints value) { this.hints = value; }

    @JsonProperty("Labels")
    public Labels getLabels() { return labels; }
    @JsonProperty("Labels")
    public void setLabels(Labels value) { this.labels = value; }
}

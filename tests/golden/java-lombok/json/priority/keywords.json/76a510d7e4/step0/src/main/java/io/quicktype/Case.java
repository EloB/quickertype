package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Case {
    private long caseCase;

    @JsonProperty("case")
    public long getCaseCase() { return caseCase; }
    @JsonProperty("case")
    public void setCaseCase(long value) { this.caseCase = value; }
}

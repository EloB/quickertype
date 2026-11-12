package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Continue {
    private long continueContinue;

    @JsonProperty("continue")
    public long getContinueContinue() { return continueContinue; }
    @JsonProperty("continue")
    public void setContinueContinue(long value) { this.continueContinue = value; }
}

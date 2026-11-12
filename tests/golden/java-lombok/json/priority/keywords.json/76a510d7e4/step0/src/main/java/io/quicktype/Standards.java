package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Standards {
    private long standards;

    @JsonProperty("Standards")
    public long getStandards() { return standards; }
    @JsonProperty("Standards")
    public void setStandards(long value) { this.standards = value; }
}

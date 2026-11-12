package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevelClass {
    private long topLevel;

    @JsonProperty("top_level")
    public long getTopLevel() { return topLevel; }
    @JsonProperty("top_level")
    public void setTopLevel(long value) { this.topLevel = value; }
}

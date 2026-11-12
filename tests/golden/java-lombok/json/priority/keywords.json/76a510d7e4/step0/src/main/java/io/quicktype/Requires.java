package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Requires {
    private long requires;

    @JsonProperty("requires")
    public long getRequires() { return requires; }
    @JsonProperty("requires")
    public void setRequires(long value) { this.requires = value; }
}

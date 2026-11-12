package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Jpipe {
    private long jpipe;

    @JsonProperty("jpipe")
    public long getJpipe() { return jpipe; }
    @JsonProperty("jpipe")
    public void setJpipe(long value) { this.jpipe = value; }
}

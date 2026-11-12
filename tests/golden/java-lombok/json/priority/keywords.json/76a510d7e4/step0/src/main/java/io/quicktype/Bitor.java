package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Bitor {
    private long bitor;

    @JsonProperty("bitor")
    public long getBitor() { return bitor; }
    @JsonProperty("bitor")
    public void setBitor(long value) { this.bitor = value; }
}

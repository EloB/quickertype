package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class SBlocks {
    private Scorer the1;

    @JsonProperty("1")
    public Scorer getThe1() { return the1; }
    @JsonProperty("1")
    public void setThe1(Scorer value) { this.the1 = value; }
}

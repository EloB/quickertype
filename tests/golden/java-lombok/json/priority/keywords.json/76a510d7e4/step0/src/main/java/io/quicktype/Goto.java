package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Goto {
    private long gotoGoto;

    @JsonProperty("goto")
    public long getGotoGoto() { return gotoGoto; }
    @JsonProperty("goto")
    public void setGotoGoto(long value) { this.gotoGoto = value; }
}

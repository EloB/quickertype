package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class New {
    private long newNew;

    @JsonProperty("new")
    public long getNewNew() { return newNew; }
    @JsonProperty("new")
    public void setNewNew(long value) { this.newNew = value; }
}

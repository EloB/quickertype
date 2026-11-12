package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Newtonsoft {
    private long newtonsoft;

    @JsonProperty("newtonsoft")
    public long getNewtonsoft() { return newtonsoft; }
    @JsonProperty("newtonsoft")
    public void setNewtonsoft(long value) { this.newtonsoft = value; }
}

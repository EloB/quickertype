package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Foreach {
    private long foreach;

    @JsonProperty("foreach")
    public long getForeach() { return foreach; }
    @JsonProperty("foreach")
    public void setForeach(long value) { this.foreach = value; }
}

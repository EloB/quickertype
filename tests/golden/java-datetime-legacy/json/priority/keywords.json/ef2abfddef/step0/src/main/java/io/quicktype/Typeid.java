package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Typeid {
    private long typeid;

    @JsonProperty("typeid")
    public long getTypeid() { return typeid; }
    @JsonProperty("typeid")
    public void setTypeid(long value) { this.typeid = value; }
}

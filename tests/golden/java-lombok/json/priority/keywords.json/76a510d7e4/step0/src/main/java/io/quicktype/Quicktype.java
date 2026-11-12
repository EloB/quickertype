package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Quicktype {
    private long quicktype;

    @JsonProperty("quicktype")
    public long getQuicktype() { return quicktype; }
    @JsonProperty("quicktype")
    public void setQuicktype(long value) { this.quicktype = value; }
}

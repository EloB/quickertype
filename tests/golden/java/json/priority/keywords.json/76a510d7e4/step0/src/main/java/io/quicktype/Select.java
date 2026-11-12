package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Select {
    private long select;

    @JsonProperty("select")
    public long getSelect() { return select; }
    @JsonProperty("select")
    public void setSelect(long value) { this.select = value; }
}

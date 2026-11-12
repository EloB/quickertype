package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Where {
    private long where;

    @JsonProperty("where")
    public long getWhere() { return where; }
    @JsonProperty("where")
    public void setWhere(long value) { this.where = value; }
}

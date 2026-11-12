package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Del {
    private long del;

    @JsonProperty("del")
    public long getDel() { return del; }
    @JsonProperty("del")
    public void setDel(long value) { this.del = value; }
}

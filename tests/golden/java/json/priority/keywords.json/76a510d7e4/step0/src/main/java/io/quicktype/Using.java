package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Using {
    private long using;

    @JsonProperty("using")
    public long getUsing() { return using; }
    @JsonProperty("using")
    public void setUsing(long value) { this.using = value; }
}

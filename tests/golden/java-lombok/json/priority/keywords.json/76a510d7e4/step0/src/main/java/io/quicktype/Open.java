package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Open {
    private long open;

    @JsonProperty("open")
    public long getOpen() { return open; }
    @JsonProperty("open")
    public void setOpen(long value) { this.open = value; }
}

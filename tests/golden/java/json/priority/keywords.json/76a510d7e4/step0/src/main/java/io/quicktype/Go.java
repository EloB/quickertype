package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Go {
    private long go;

    @JsonProperty("go")
    public long getGo() { return go; }
    @JsonProperty("go")
    public void setGo(long value) { this.go = value; }
}

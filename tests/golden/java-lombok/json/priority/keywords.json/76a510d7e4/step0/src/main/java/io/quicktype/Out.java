package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Out {
    private long out;

    @JsonProperty("out")
    public long getOut() { return out; }
    @JsonProperty("out")
    public void setOut(long value) { this.out = value; }
}

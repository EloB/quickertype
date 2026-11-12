package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class TopLevelBla {
    private long bar;

    @JsonProperty("bar")
    public long getBar() { return bar; }
    @JsonProperty("bar")
    public void setBar(long value) { this.bar = value; }
}

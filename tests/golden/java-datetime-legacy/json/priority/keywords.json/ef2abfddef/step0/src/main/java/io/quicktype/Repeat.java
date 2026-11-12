package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Repeat {
    private long repeat;

    @JsonProperty("repeat")
    public long getRepeat() { return repeat; }
    @JsonProperty("repeat")
    public void setRepeat(long value) { this.repeat = value; }
}

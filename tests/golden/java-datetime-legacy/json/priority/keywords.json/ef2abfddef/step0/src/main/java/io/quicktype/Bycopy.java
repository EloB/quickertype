package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Bycopy {
    private long bycopy;

    @JsonProperty("bycopy")
    public long getBycopy() { return bycopy; }
    @JsonProperty("bycopy")
    public void setBycopy(long value) { this.bycopy = value; }
}

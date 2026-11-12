package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Indirect {
    private long indirect;

    @JsonProperty("indirect")
    public long getIndirect() { return indirect; }
    @JsonProperty("indirect")
    public void setIndirect(long value) { this.indirect = value; }
}

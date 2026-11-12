package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Explicit {
    private long explicit;

    @JsonProperty("explicit")
    public long getExplicit() { return explicit; }
    @JsonProperty("explicit")
    public void setExplicit(long value) { this.explicit = value; }
}

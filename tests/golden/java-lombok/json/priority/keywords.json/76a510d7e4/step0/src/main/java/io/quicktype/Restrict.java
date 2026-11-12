package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Restrict {
    private long restrict;

    @JsonProperty("restrict")
    public long getRestrict() { return restrict; }
    @JsonProperty("restrict")
    public void setRestrict(long value) { this.restrict = value; }
}

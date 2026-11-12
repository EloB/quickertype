package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class As {
    private long as;

    @JsonProperty("as")
    public long getAs() { return as; }
    @JsonProperty("as")
    public void setAs(long value) { this.as = value; }
}

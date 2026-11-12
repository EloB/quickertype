package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class And {
    private long and;

    @JsonProperty("and")
    public long getAnd() { return and; }
    @JsonProperty("and")
    public void setAnd(long value) { this.and = value; }
}

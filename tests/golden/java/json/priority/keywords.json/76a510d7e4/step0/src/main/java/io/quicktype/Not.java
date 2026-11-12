package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Not {
    private long not;

    @JsonProperty("not")
    public long getNot() { return not; }
    @JsonProperty("not")
    public void setNot(long value) { this.not = value; }
}

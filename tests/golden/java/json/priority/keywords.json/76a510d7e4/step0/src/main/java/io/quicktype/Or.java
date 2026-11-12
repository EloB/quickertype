package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Or {
    private long or;

    @JsonProperty("or")
    public long getOr() { return or; }
    @JsonProperty("or")
    public void setOr(long value) { this.or = value; }
}

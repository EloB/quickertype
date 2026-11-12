package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Decltype {
    private long decltype;

    @JsonProperty("decltype")
    public long getDecltype() { return decltype; }
    @JsonProperty("decltype")
    public void setDecltype(long value) { this.decltype = value; }
}

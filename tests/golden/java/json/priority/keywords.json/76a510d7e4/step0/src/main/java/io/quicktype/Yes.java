package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Yes {
    private long yes;

    @JsonProperty("YES")
    public long getYes() { return yes; }
    @JsonProperty("YES")
    public void setYes(long value) { this.yes = value; }
}

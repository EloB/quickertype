package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class CoYield {
    private long coYield;

    @JsonProperty("co_yield")
    public long getCoYield() { return coYield; }
    @JsonProperty("co_yield")
    public void setCoYield(long value) { this.coYield = value; }
}

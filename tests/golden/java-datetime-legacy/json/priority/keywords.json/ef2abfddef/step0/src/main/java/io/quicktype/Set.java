package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Set {
    private long set;

    @JsonProperty("set")
    public long getSet() { return set; }
    @JsonProperty("set")
    public void setSet(long value) { this.set = value; }
}

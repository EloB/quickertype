package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class Auto {
    private long auto;

    @JsonProperty("auto")
    public long getAuto() { return auto; }
    @JsonProperty("auto")
    public void setAuto(long value) { this.auto = value; }
}

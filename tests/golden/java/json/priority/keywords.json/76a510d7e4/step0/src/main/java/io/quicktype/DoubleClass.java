package io.quicktype;

import com.fasterxml.jackson.annotation.*;

public class DoubleClass {
    private long doubleDouble;

    @JsonProperty("double")
    public long getDoubleDouble() { return doubleDouble; }
    @JsonProperty("double")
    public void setDoubleDouble(long value) { this.doubleDouble = value; }
}
